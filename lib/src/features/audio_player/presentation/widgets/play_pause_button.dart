import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(context, ref) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return StreamBuilder(
      stream: audioPlayer.value?.listenToPlayingState,
      builder: (context, snapshot) {
        return InkWell(
          onTapDown: (_) {
            audioPlayer.value?.stop();
          },
          child: IconButton.outlined(
            iconSize: 35,
            color: Theme.of(context).colorScheme.onSurface,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            onPressed: () {
              if (snapshot.data ?? false) {
                audioPlayer.value?.pause();
              } else {
                audioPlayer.value?.play();
              }
            },
            icon: Icon(
              switch (snapshot.data ?? false) {
                true => Icons.pause_outlined,
                false => Icons.play_arrow,
              },
            ),
          ),
        );
      },
    );
  }
}
