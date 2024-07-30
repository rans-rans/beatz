import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/features/audio_player/presentation/widgets/play_pause_button.dart';
import 'package:beatz/src/features/audio_player/presentation/widgets/set_looping_button.dart';
import 'package:beatz/src/features/audio_player/presentation/widgets/set_shuffle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingButtons extends ConsumerWidget {
  const NowPlayingButtons({super.key});

  @override
  Widget build(context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SetLoopingButton(),
        IconButton.outlined(
          icon: const Icon(Icons.skip_previous),
          color: Theme.of(context).colorScheme.onSurface,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            // ref.read(audioPlayerProvider)?.seekToPrevious();
            ref.read(audioPlayerProvider).value?.skipToPrevious();
          },
        ),
        // the
        const PlayPauseButton(),
        IconButton.outlined(
          color: Theme.of(context).colorScheme.onSurface,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          icon: const Icon(Icons.skip_next),
          onPressed: () {
            // ref.read(audioPlayerProvider)?.seekToNext();
            ref.read(audioPlayerProvider).value?.skipToNext();
          },
        ),
        const SetShuffleButton()
      ],
    );
  }
}
