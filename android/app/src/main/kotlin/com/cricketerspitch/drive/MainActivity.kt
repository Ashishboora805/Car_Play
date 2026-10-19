package com.cricketerspitch.drive

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ClipData
import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.core.app.NotificationCompat
import androidx.core.content.FileProvider
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

class MainActivity : AudioServiceActivity() {
    private val filesExecutor = Executors.newSingleThreadExecutor()
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "cpdrive/browser_files").setMethodCallHandler { call, result ->
            when (call.method) {
                "openIntent" -> try {
                    val intent = Intent.parseUri(requireNotNull(call.argument<String>("url")), Intent.URI_INTENT_SCHEME)
                    require(intent.data?.scheme !in listOf("file", "content", "javascript", "data", "about"))
                    intent.action = Intent.ACTION_VIEW
                    intent.component = null
                    intent.selector = null
                    intent.addCategory(Intent.CATEGORY_BROWSABLE)
                    intent.flags = 0
                    startActivity(intent)
                    result.success(true)
                } catch (_: Exception) { result.success(false) }
                "publish" -> filesExecutor.execute {
                    try {
                        val source = File(requireNotNull(call.argument<String>("path"))).canonicalFile
                        require(source.path.startsWith(cacheDir.canonicalPath + File.separator) && source.isFile)
                        val name = requireNotNull(call.argument<String>("name"))
                        require(name.isNotBlank() && name.length <= 160 && !name.contains('/') && !name.contains('\\'))
                        val mime = call.argument<String>("mime") ?: "application/octet-stream"
                        val location: String
                        if (Build.VERSION.SDK_INT >= 29) {
                            val values = ContentValues().apply {
                                put(MediaStore.Downloads.DISPLAY_NAME, name)
                                put(MediaStore.Downloads.MIME_TYPE, mime)
                                put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS + "/CP Drive")
                                put(MediaStore.Downloads.IS_PENDING, 1)
                            }
                            val uri = requireNotNull(contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values))
                            try {
                                requireNotNull(contentResolver.openOutputStream(uri)).use { output -> source.inputStream().use { it.copyTo(output) } }
                                contentResolver.update(uri, ContentValues().apply { put(MediaStore.Downloads.IS_PENDING, 0) }, null, null)
                                location = uri.toString()
                            } catch (failure: Exception) { contentResolver.delete(uri, null, null); throw failure }
                        } else {
                            val directory = requireNotNull(getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS))
                            val target = File(directory, "${System.currentTimeMillis()}_$name")
                            source.copyTo(target, overwrite = false)
                            location = target.absolutePath
                        }
                        source.delete()
                        runOnUiThread {
                            try { notifyComplete(location, mime, call.argument<String>("title") ?: name, name) } catch (_: Exception) { }
                            result.success(mapOf("location" to location, "name" to name, "mime" to mime))
                        }
                    } catch (failure: Exception) { runOnUiThread { result.error("DOWNLOAD_SAVE", failure.message, null) } }
                }
                "open", "share" -> try {
                    val location = requireNotNull(call.argument<String>("location"))
                    val uri = downloadUri(location)
                    val mime = call.argument<String>("mime") ?: contentResolver.getType(uri) ?: "application/octet-stream"
                    val intent = if (call.method == "share") Intent(Intent.ACTION_SEND).apply {
                        type = mime; putExtra(Intent.EXTRA_STREAM, uri); clipData = ClipData.newRawUri("Download", uri)
                    } else Intent(Intent.ACTION_VIEW).setDataAndType(uri, mime)
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    startActivity(if (call.method == "share") Intent.createChooser(intent, null) else intent)
                    result.success(null)
                } catch (failure: Exception) { result.error("DOWNLOAD_OPEN", failure.message, null) }
                "delete" -> filesExecutor.execute {
                    try {
                        val location = requireNotNull(call.argument<String>("location"))
                        val removed = if (location.startsWith("content://")) {
                            val uri = downloadUri(location)
                            val exists = contentResolver.query(uri, arrayOf(MediaStore.Downloads._ID), null, null, null)?.use { it.moveToFirst() } ?: false
                            !exists || contentResolver.delete(uri, null, null) > 0
                        } else { val file = checkedFile(location); !file.exists() || file.delete() }
                        runOnUiThread { result.success(removed) }
                    } catch (failure: Exception) { runOnUiThread { result.error("DOWNLOAD_DELETE", failure.message, null) } }
                }
                else -> result.notImplemented()
            }
        }
    }
    private fun checkedFile(location: String): File {
        val file = File(location).canonicalFile
        val directory = requireNotNull(getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)).canonicalFile
        require(file.path.startsWith(directory.path + File.separator))
        return file
    }
    private fun downloadUri(location: String): Uri {
        if (!location.startsWith("content://")) return FileProvider.getUriForFile(this, "$packageName.browser_files", checkedFile(location))
        val uri = Uri.parse(location)
        require(uri.scheme == "content" && uri.authority == "media" && uri.pathSegments.size == 3 && uri.pathSegments[1] == "downloads")
        requireNotNull(uri.lastPathSegment?.toLongOrNull())
        return uri
    }
    private fun notifyComplete(location: String, mime: String, title: String, name: String) {
        val manager = getSystemService(NotificationManager::class.java)
        if (Build.VERSION.SDK_INT >= 26) manager.createNotificationChannel(NotificationChannel("cpdrive_downloads", "Downloads", NotificationManager.IMPORTANCE_DEFAULT))
        val uri = downloadUri(location)
        val open = Intent(Intent.ACTION_VIEW).setDataAndType(uri, mime).addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        val pending = PendingIntent.getActivity(this, location.hashCode(), open, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        manager.notify(location.hashCode(), NotificationCompat.Builder(this, "cpdrive_downloads")
            .setSmallIcon(android.R.drawable.stat_sys_download_done).setContentTitle(title).setContentText(name)
            .setContentIntent(pending).setAutoCancel(true).build())
    }
}
