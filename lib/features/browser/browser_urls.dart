Uri browserAddress(String input) {
  final text = input.trim();
  if (text.isEmpty) {
    return Uri.parse('about:blank');
  }
  final explicit = Uri.tryParse(text);
  if (explicit != null &&
      ['https', 'http'].contains(explicit.scheme.toLowerCase()) &&
      explicit.host.isNotEmpty &&
      !text.contains(RegExp(r'\s'))) {
    return explicit;
  }
  if (!text.contains(RegExp(r'\s')) &&
      !text.contains('://') &&
      (text.contains('.') || text.startsWith('localhost'))) {
    final candidate = Uri.tryParse('https://$text');
    if (candidate != null &&
        candidate.host.isNotEmpty &&
        !candidate.host.contains('@')) {
      return candidate;
    }
  }
  return Uri.https('www.google.com', '/search', {'q': text});
}

bool isWebAddress(Uri url) =>
    ['http', 'https'].contains(url.scheme.toLowerCase()) &&
    url.host.isNotEmpty &&
    url.userInfo.isEmpty;
Uri? intentFallback(String input) {
  final match = RegExp(r'(?:#Intent;|;)S\.browser_fallback_url=([^;]+)')
      .firstMatch(input);
  if (match == null) {
    return null;
  }
  try {
    final uri = Uri.parse(Uri.decodeComponent(match.group(1)!));
    return isWebAddress(uri) ? uri : null;
  } catch (_) {
    return null;
  }
}

String safeDownloadName(String value) {
  var name = value
      .split(RegExp(r'[/\\]'))
      .last
      .replaceAll(RegExp(r'[\x00-\x1f<>:"|?*]'), '_')
      .trim();
  name = name.replaceAll(RegExp(r'^\.+|[. ]+$'), '');
  if (name.isEmpty) {
    name = 'download';
  }
  return name.length > 160 ? name.substring(name.length - 160) : name;
}
