import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import 'browser_downloads.dart';
import 'browser_models.dart';
import 'browser_store.dart';
import 'browser_urls.dart';

enum BrowserLibrarySection { bookmarks, history, downloads }

Future<bool> browserConfirm(
  BuildContext context,
  String title, {
  String? detail,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) {
        final text = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(title),
          content: detail == null ? null : Text(detail),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(text.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(text.allow),
            ),
          ],
        );
      },
    ) ??
    false;
Future<void> editBookmark(
  BuildContext context,
  BrowserStore store,
  BrowserEntry entry,
) async {
  final title = TextEditingController(text: entry.title);
  final url = TextEditingController(text: entry.url);
  final form = GlobalKey<FormState>();
  final text = AppLocalizations.of(context)!;
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text.addBookmark),
      content: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(labelText: text.title),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: url,
                decoration: InputDecoration(labelText: text.url),
                validator: (value) =>
                    isWebAddress(Uri.tryParse(value ?? '') ?? Uri())
                    ? null
                    : text.invalidUrl,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'delete'),
          child: Text(text.delete),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(text.cancel),
        ),
        FilledButton(
          onPressed: () {
            if (form.currentState!.validate()) {
              Navigator.pop(context, 'save');
            }
          },
          child: Text(text.save),
        ),
      ],
    ),
  );
  try {
    if (result == 'save') {
      await store.bookmark(
        url.text.trim(),
        title.text.trim(),
        previousUrl: entry.url,
      );
    } else if (result == 'delete') {
      await store.removeBookmark(entry.url);
    }
  } finally {
    title.dispose();
    url.dispose();
  }
}

class BrowserLibraryScreen extends StatefulWidget {
  const BrowserLibraryScreen({
    super.key,
    required this.section,
    required this.store,
    required this.downloads,
  });
  final BrowserLibrarySection section;
  final BrowserStore store;
  final BrowserDownloads downloads;
  @override
  State<BrowserLibraryScreen> createState() => _BrowserLibraryScreenState();
}

class _BrowserLibraryScreenState extends State<BrowserLibraryScreen> {
  String search = '';
  late Future<List<BrowserEntry>> entries;
  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    entries = widget.section == BrowserLibrarySection.bookmarks
        ? widget.store.bookmarks()
        : widget.store.history(search);
  }

  Future<void> run(Future<void> Function() operation) async {
    try {
      await operation();
      if (mounted) {
        setState(reload);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.actionFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final section = widget.section;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [text.bookmarks, text.history, text.downloads][section.index],
        ),
        actions: [
          if (section == BrowserLibrarySection.history)
            IconButton(
              tooltip: text.clearHistory,
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => run(() async {
                if (await browserConfirm(context, text.clearConfirm)) {
                  await widget.store.clearHistory();
                }
              }),
            ),
        ],
      ),
      body: SafeArea(
        child: section == BrowserLibrarySection.downloads
            ? ListenableBuilder(
                listenable: widget.downloads,
                builder: (context, child) {
                  final data = widget.downloads.items;
                  if (data.isEmpty) {
                    return Center(child: Text(text.noDownloads));
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                item.status == 'complete'
                                    ? text.downloadComplete
                                    : item.status == 'failed'
                                    ? text.downloadFailed
                                    : text.downloading,
                              ),
                              Text(
                                '${(item.bytes / 1048576).toStringAsFixed(2)} MB',
                              ),
                              if (item.status == 'downloading')
                                LinearProgressIndicator(
                                  value: item.total == null || item.total == 0
                                      ? null
                                      : (item.bytes / item.total!).clamp(0, 1),
                                ),
                              Wrap(
                                children: [
                                  if (item.status == 'complete')
                                    TextButton(
                                      onPressed: () => run(
                                        () => widget.downloads.platform.open(
                                          item.location,
                                          item.mime,
                                        ),
                                      ),
                                      child: Text(text.open),
                                    ),
                                  if (item.status == 'complete')
                                    TextButton(
                                      onPressed: () => run(
                                        () => widget.downloads.platform.share(
                                          item.location,
                                          item.mime,
                                        ),
                                      ),
                                      child: Text(text.share),
                                    ),
                                  TextButton(
                                    onPressed: () => run(() async {
                                      if (item.status == 'downloading' ||
                                          await browserConfirm(
                                            context,
                                            text.deleteDownload,
                                            detail: text.downloadHint,
                                          )) {
                                        await widget.downloads.remove(item);
                                      }
                                    }),
                                    child: Text(
                                      item.status == 'downloading'
                                          ? text.stop
                                          : text.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Column(
                children: [
                  if (section == BrowserLibrarySection.history)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: text.searchHistory,
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: (value) => setState(() {
                          search = value;
                          reload();
                        }),
                      ),
                    ),
                  Expanded(
                    child: FutureBuilder<List<BrowserEntry>>(
                      future: entries,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: TextButton(
                              onPressed: () => setState(reload),
                              child: Text(text.retry),
                            ),
                          );
                        }
                        final data = snapshot.data;
                        if (data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (data.isEmpty) {
                          return Center(
                            child: Text(
                              section == BrowserLibrarySection.bookmarks
                                  ? text.noBookmarks
                                  : text.noHistory,
                            ),
                          );
                        }
                        String? previousDay;
                        return ListView(
                          children: [
                            for (final entry in data) ...[
                              if (section == BrowserLibrarySection.history &&
                                  previousDay !=
                                      DateFormat.yMMMd(
                                        Localizations.localeOf(context)
                                            .toLanguageTag(),
                                      ).format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          entry.time,
                                        ),
                                      ))
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    previousDay =
                                        DateFormat.yMMMd(
                                          Localizations.localeOf(context)
                                              .toLanguageTag(),
                                        ).format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            entry.time,
                                          ),
                                        ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                ),
                              ListTile(
                                title: Text(
                                  entry.title.isEmpty ? entry.url : entry.title,
                                ),
                                subtitle: Text(
                                  entry.url,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () => Navigator.pop(context, entry.url),
                                trailing:
                                    section == BrowserLibrarySection.bookmarks
                                    ? PopupMenuButton<String>(
                                        onSelected: (value) => run(
                                          () => value == 'edit'
                                              ? editBookmark(
                                                  context,
                                                  widget.store,
                                                  entry,
                                                )
                                              : widget.store.removeBookmark(
                                                  entry.url,
                                                ),
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text(text.edit),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text(text.delete),
                                          ),
                                        ],
                                      )
                                    : null,
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
