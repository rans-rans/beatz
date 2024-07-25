import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(context, ref) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return StreamBuilder(
      stream: audioPlayer?.listenToPlayingState,
      builder: (context, snapshot) {
        return InkWell(
          onTapDown: (_) {
            audioPlayer?.stop();
          },
          child: IconButton.outlined(
            iconSize: 35,
            onPressed: () {
              if (snapshot.data ?? false) {
                audioPlayer?.pause();
              } else {
                audioPlayer?.play();
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
