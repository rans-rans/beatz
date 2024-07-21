import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
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
