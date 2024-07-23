import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayPauseButton extends ConsumerWidget {
  final bool isDark;
  final bool canStop;
  const PlayPauseButton({
    super.key,
    this.isDark = false,
    this.canStop = false,
  });

  @override
  Widget build(context, ref) {
    final audioPlayer = ref.watch(audioPlayerProvider);
    return StreamBuilder(
      stream: audioPlayer?.listenToPlayingState,
      builder: (context, snapshot) {
        return GestureDetector(
          onLongPress: () {
            if (canStop == false) return;
            ref.read(audioPlayerProvider.notifier).disposePlayer();
            ref.read(audioViewProvider.notifier).closePlayer();
          },
          child: IconButton(
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
          ),
        );
      },
    );
  }
}
