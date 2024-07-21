import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class NowPlayingText extends ConsumerStatefulWidget {
  final Color? fontColor;
  final double? fontSize;
  const NowPlayingText({super.key, this.fontColor, this.fontSize});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingTextState();
}

class _NowPlayingTextState extends ConsumerState<NowPlayingText>
    with WidgetsBindingObserver {
  final currentAudioTitle = ValueNotifier('');
  String currentPath = '';
  late AudioPlayer? audioPlayerProv;

  void getText() {
    audioPlayerProv = ref.read(audioPlayerProvider);

    audioPlayerProv?.positionStream.listen(
      (posData) {
        final currentAudioIndex = audioPlayerProv?.currentIndex ?? 0;
        ConcatenatingAudioSource? concatenatingAudioSource;
        ProgressiveAudioSource? progressiveAudioSource;
        final audioSource = audioPlayerProv?.audioSource;
        if (audioSource is ConcatenatingAudioSource) {
          concatenatingAudioSource = audioSource;
        }
        if (audioSource is ProgressiveAudioSource) {
          progressiveAudioSource = audioSource;
        }
        late String path;
        late String audioTitle;
        late MediaItem mediaItem;

        if (progressiveAudioSource != null) {
          mediaItem =
              progressiveAudioSource.sequence[currentAudioIndex].tag as MediaItem;
        }
        if (concatenatingAudioSource != null) {
          mediaItem =
              concatenatingAudioSource.sequence[currentAudioIndex].tag as MediaItem;
        }
        path = mediaItem.id;
        audioTitle = mediaItem.displayTitle ?? getFileName(path);

        if (path != currentPath) {
          currentPath = path;
          currentAudioTitle.value = audioTitle;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getText();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getText();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentAudioTitle,
      builder: (context, currTitle, child) {
        return Text(
          currTitle,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: widget.fontColor,
            fontSize: widget.fontSize,
          ),
        );
      },
    );
  }
}
