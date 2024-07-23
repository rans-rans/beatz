import 'dart:convert';

import 'package:flutter/widgets.dart';

class Audio {
  final String path;
  final String? album;
  final String? artist;
  final String? title;
  final Duration? duration;
  Audio({
    required this.path,
    this.album,
    this.artist,
    this.title,
    this.duration,
  });

  Audio copyWith({
    String? path,
    ValueGetter<String?>? album,
    ValueGetter<String?>? artist,
    ValueGetter<String?>? title,
    ValueGetter<Duration?>? duration,
  }) {
    return Audio(
      path: path ?? this.path,
      album: album != null ? album() : this.album,
      artist: artist != null ? artist() : this.artist,
      title: title != null ? title() : this.title,
      duration: duration != null ? duration() : this.duration,
    );
  }

  factory Audio.fromMap(Map<String, dynamic> map) {
    return Audio(
      path: map['path'] ?? '',
      album: map['album'],
      artist: map['artist'],
      title: map['title'],
      duration: Duration(milliseconds: map['duration'] ?? 0),
    );
  }

  @override
  String toString() {
    return 'Audio(path: $path, album: $album, artist: $artist, title: $title, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Audio &&
        other.path == path &&
        other.album == album &&
        other.artist == artist &&
        other.title == title &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return path.hashCode ^
        album.hashCode ^
        artist.hashCode ^
        title.hashCode ^
        duration.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'album': album,
      'artist': artist,
      'title': title,
      'duration': duration?.inMilliseconds ?? 0,
    };
  }

  String toJson() => json.encode(toMap());

  factory Audio.fromJson(String source) => Audio.fromMap(json.decode(source));
}
