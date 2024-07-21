import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetShuffleButton extends ConsumerWidget {
  const SetShuffleButton({
    super.key,
  });

  @override
  Widget build(context, ref) {
    return StreamBuilder(
      stream: ref.read(audioPlayerProvider)?.shuffleModeEnabledStream,
      builder: (context, snapshot) {
        return IconButton(
          icon: Icon(
            switch (snapshot.data ?? false) {
              true => Icons.shuffle_on_outlined,
              false => Icons.shuffle,
            },
            color: Colors.white,
          ),
          onPressed: () {
            ref.read(audioPlayerProvider.notifier).toggleShuffuleMode();
          },
        );
      },
    );
  }
}
