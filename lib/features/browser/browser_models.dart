import 'dart:typed_data';

class BrowserTab {
  BrowserTab({
    required this.id,
    this.url = 'about:blank',
    this.title = '',
    this.incognito = false,
    this.desktop = false,
    this.zoom = 100,
    this.thumbnail,
    this.windowId,
  });
  final String id;
  String url;
  String title;
  final bool incognito;
  bool desktop;
  int zoom;
  Uint8List? thumbnail;
  int? windowId;
  bool visited = false;
  Map<String, Object?> toMap(int position) => {
    'id': id,
    'url': url,
    'title': title,
    'position': position,
    'desktop': desktop ? 1 : 0,
    'zoom': zoom,
    'thumbnail': thumbnail,
  };
  factory BrowserTab.fromMap(Map<String, Object?> value) => BrowserTab(
    id: value['id'] as String,
    url: value['url'] as String,
    title: value['title'] as String,
    desktop: value['desktop'] == 1,
    zoom: (value['zoom'] as int).clamp(50, 200),
    thumbnail: value['thumbnail'] as Uint8List?,
  );
}

class BrowserEntry {
  BrowserEntry({required this.url, required this.title, required this.time});
  final String url, title;
  final int time;
}

class BrowserDownload {
  BrowserDownload({
    required this.id,
    required this.name,
    required this.created,
    this.url = '',
    this.location = '',
    this.mime = 'application/octet-stream',
    this.status = 'downloading',
    this.bytes = 0,
  });
  final String id;
  String name, url, location, mime, status;
  final int created;
  int bytes;
  int? total;
  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'created': created,
    'url': url,
    'location': location,
    'mime': mime,
    'status': status,
    'bytes': bytes,
  };
  factory BrowserDownload.fromMap(Map<String, Object?> m) => BrowserDownload(
    id: m['id'] as String,
    name: m['name'] as String,
    created: m['created'] as int,
    url: m['url'] as String,
    location: m['location'] as String,
    mime: m['mime'] as String,
    status: m['status'] as String,
    bytes: m['bytes'] as int,
  );
}
