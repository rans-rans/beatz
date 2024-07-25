import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/domain/repositories/audio_player_repo.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowPlayingText extends ConsumerStatefulWidget {
  final double? fontSize;
  const NowPlayingText({super.key, this.fontSize});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingTextState();
}

class _NowPlayingTextState extends ConsumerState<NowPlayingText>
    with WidgetsBindingObserver {
  final currentAudioTitle = ValueNotifier('');
  String currentPath = '';
  late AudioPlayerRepo? audioPlayerProv;

  void getText() {
    final audioPlayerProv = ref.read(audioPlayerProvider);
    audioPlayerProv?.listenToPosition.listen(
      (posData) {
        if (ref.context.mounted == false) return;
        final path = ref.read(audioPlayerProvider.notifier).currentAudioPath;
        if (currentPath == path) return;
        currentPath = path;
        currentAudioTitle.value = getFileName(path);
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
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500,
            color: switch (Theme.of(context).brightness == Brightness.light) {
              true => Colors.black,
              false => Colors.white,
            },
          ),
        );
      },
    );
  }
}
