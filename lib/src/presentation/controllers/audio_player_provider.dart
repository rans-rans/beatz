import 'package:beatz/src/data/repositories/just_audio_datasource.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/domain/repositories/audio_player_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerProvider extends StateNotifier<AudioPlayerRepo?> {
  AudioPlayerProvider() : super(null);

  bool shuffuleEnabled = false;
  List<Audio> _currentChildren = [];

  String get currentAudioPath {
    return _currentChildren[state?.currentIndex ?? 0].path;
  }

  int get currentIndex {
    return state?.currentIndex ?? 0;
  }

  Future<void> initialize(String audioPath) async {
    if (state != null && currentAudioPath == audioPath) return;
    await disposePlayer();
    state = JustAudioDatasource();
    _currentChildren = [Audio(path: audioPath)];
    await state?.setAudioSource(sources: _currentChildren);
    state?.play();
  }

  Future<void> initializePlaylist(List<String> audioPaths) async {
    await disposePlayer();
    _currentChildren = audioPaths.map((e) => Audio(path: e)).toList();
    state = JustAudioDatasource();
    await state?.setAudioSource(sources: _currentChildren);
    await state?.setShuffledEnabled(shuffuleEnabled);
    state?.play();
  }

  Future<void> disposePlayer() async {
    await state?.stop();
    await state?.dispose();
    state = null;
    _currentChildren = [];
  }

  void toggleShuffuleMode() async {
    shuffuleEnabled = !state!.shuffleEnabled;
    state!.setShuffledEnabled(shuffuleEnabled);
  }

  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerProvider, AudioPlayerRepo?>((ref) {
  return AudioPlayerProvider();
});
