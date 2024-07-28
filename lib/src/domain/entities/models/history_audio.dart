import 'dart:convert';

class HistoryAudio {
  final String audioPath;
  final DateTime lastPlayed;

  HistoryAudio({
    required this.audioPath,
    required this.lastPlayed,
  });

  Map<String, dynamic> toMap() {
    return {
      'audioPath': audioPath,
      'lastPlayed': lastPlayed.millisecondsSinceEpoch,
    };
  }

  factory HistoryAudio.fromMap(Map<String, dynamic> map) {
    return HistoryAudio(
      audioPath: map['audioPath'] ?? '',
      lastPlayed: DateTime.fromMillisecondsSinceEpoch(map['lastPlayed']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryAudio.fromJson(String source) =>
      HistoryAudio.fromMap(json.decode(source));
}
