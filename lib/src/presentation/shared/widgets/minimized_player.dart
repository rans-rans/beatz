import 'dart:ui';

import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/constants/number_constants.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/screens/music%20player/widgets/play_pause_button.dart';
import 'package:beatz/src/presentation/shared/widgets/now_playing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class MinimizedPlayer extends ConsumerStatefulWidget {
  const MinimizedPlayer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MinimizedPlayerState();
}

class _MinimizedPlayerState extends ConsumerState<MinimizedPlayer> {
  @override
  Widget build(context) {
    final audioProvider = ref.watch(audioPlayerProvider);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 4),
        child: StreamBuilder(
            stream: audioProvider?.playerStateStream,
            builder: (context, snapshot) {
              final processingState = snapshot.data?.processingState;
              final playing = snapshot.data?.playing ?? false;
              if (processingState == null ||
                  processingState == ProcessingState.idle ||
                  !playing ||
                  audioProvider == null) {
                return const SizedBox.shrink();
              }
              final audioViewState = ref.watch(audioViewProvider);
              return switch (audioViewState) {
                AudioViewState.dismissed => const SizedBox.shrink(),
                AudioViewState.minimized => SizedBox(
                    height: minimizedPlayerHeight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          NavigateToMusicPlayerAnimation(),
                        ).then((_) {
                          ref.read(audioViewProvider.notifier).minimizePlayer();
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 5,
                            child: StreamBuilder(
                                stream: audioProvider.positionStream,
                                builder: (context, snapshot) {
                                  double position = (snapshot.data?.inSeconds ?? 0) /
                                      (audioProvider.duration?.inSeconds ?? 1);

                                  return LinearProgressIndicator(value: position);
                                }),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: NowPlayingText()),
                                PlayPauseButton(isDark: true, canStop: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              };
            }),
      ),
    );
  }
}
