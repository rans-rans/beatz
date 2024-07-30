import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helper_functions.dart';

void initializeIntentAudioFiles(
    WidgetRef ref, List<String> musicPaths, BuildContext context) {
  if (musicPaths.isEmpty) return;
  final validSongs = <String>[];
  for (var path in musicPaths) {
    final isMusic = isMusicFile(path);
    if (isMusic) {
      validSongs.add(path);
    }
  }

  ref.read(audioPlayerProvider.notifier).initializePlaylist(validSongs).then((_) {
    ref.read(audioViewProvider.notifier).minimizePlayer();
  });
}
