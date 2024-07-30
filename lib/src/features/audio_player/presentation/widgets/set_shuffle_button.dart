import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetShuffleButton extends ConsumerWidget {
  const SetShuffleButton({
    super.key,
  });

  @override
  Widget build(context, ref) {
    return StreamBuilder(
      stream: ref.read(audioPlayerProvider).value?.listenToShuffle,
      builder: (context, snapshot) {
        return IconButton(
          color: Theme.of(context).colorScheme.onSurface,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          icon: Icon(
            switch (snapshot.data ?? false) {
              true => Icons.shuffle_on_outlined,
              false => Icons.shuffle,
            },
          ),
          onPressed: () {
            ref.read(audioPlayerProvider.notifier).toggleShuffuleMode();
          },
        );
      },
    );
  }
}
