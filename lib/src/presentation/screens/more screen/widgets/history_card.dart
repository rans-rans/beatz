import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/domain/entities/models/history_audio.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryCard extends ConsumerWidget {
  final HistoryAudio historyAudio;
  const HistoryCard({required this.historyAudio, super.key});

  @override
  Widget build(context, ref) {
    return InkWell(
      onTap: () {
        ref
            .read(audioPlayerProvider.notifier)
            .initialize(historyAudio.audioPath)
            .then((_) {
          Navigator.push(context, NavigateToMusicPlayerAnimation());
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.music_note,
            size: 90,
          ),
          Text(
            getFileName(historyAudio.audioPath),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
