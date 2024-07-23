import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioViewProvider extends StateNotifier<AudioViewState> {
  AudioViewProvider() : super(AudioViewState.dismissed);

  void minimizePlayer() {
    state = AudioViewState.minimized;
  }

  void closePlayer() {
    state = AudioViewState.dismissed;
  }
}

final audioViewProvider = StateNotifierProvider<AudioViewProvider, AudioViewState>(
  (ref) => AudioViewProvider(),
);

enum AudioViewState { minimized, dismissed }
