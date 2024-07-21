bool isMusicFile(String path) {
  final extensions = [
    'wav',
    'aiff',
    'pcm',
    'mp3',
    'aac',
    'ogg',
    'wma',
    'flac',
    'alac',
    'ape',
    'm4a',
    'wavpack'
  ];

  return extensions.any((ext) => path.toLowerCase().endsWith(ext));
}

String getFileName(String path) => path.split('/').last.split('.').first;

String getFormattedTime(Duration duration) {
  return """${duration.inHours.toString().padLeft(2, "0")}:"""
      """${(duration.inMinutes % 60).toString().padLeft(2, "0")}:"""
      """${(duration.inSeconds % 60).toString().padLeft(2, "0")}""";
}
