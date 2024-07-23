import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPauseButton extends ConsumerWidget {
  final bool isDark;
  const PlayPauseButton({super.key, this.isDark = false});

  @override
  Widget build(context, ref) {
    final audioPlayer = ref.read(audioPlayerProvider);
    return StreamBuilder(
      stream: audioPlayer?.listenToPlayingState,
      builder: (context, snapshot) {
        return IconButton(
          iconSize: 25,
          style: IconButton.styleFrom(
            side: BorderSide(color: isDark ? Colors.black : Colors.white),
          ),
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
            color: isDark ? Colors.black : Colors.white,
          ),
        );
      },
    );
  }
}
