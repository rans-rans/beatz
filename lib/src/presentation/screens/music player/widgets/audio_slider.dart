import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioSlider extends ConsumerWidget {
  const AudioSlider({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final audioData = ref.read(audioPlayerProvider);
    return StreamBuilder(
      stream: audioData?.listenToPosition,
      builder: (context, snapshot) {
        final progress = snapshot.data ?? Duration.zero;
        return Column(
          children: [
            Slider(
              min: 0,
              max: audioData?.getAudioLength.inSeconds.toDouble() ?? 0.0,
              value: progress.inSeconds.roundToDouble(),
              onChanged: (value) {
                seekAudio(ref, value);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getFormattedTime(progress),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    getFormattedTime(audioData?.getAudioLength ?? Duration.zero),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void>? seekAudio(WidgetRef ref, double value) {
    return ref.read(audioPlayerProvider)?.seekToPosition(
          Duration(seconds: value.toInt()),
        );
  }
}
