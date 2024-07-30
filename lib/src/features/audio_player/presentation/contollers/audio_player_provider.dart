import 'dart:async';
import 'dart:convert';

import 'package:beatz/shared/constants/string_constants.dart';
import 'package:beatz/src/data/datasource/key_value_store.dart';
import 'package:beatz/src/data/datasource/shared_preferences_datasource.dart';
import 'package:beatz/src/data/repositories/just_audio_datasource.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/domain/entities/models/history_audio.dart';
import 'package:beatz/src/features/audio_player/domain/repositories/audio_player_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayerProvider extends AsyncNotifier<AudioPlayerRepo?> {
  final KeyValueStore keyValueStore;
  AudioPlayerProvider({required this.keyValueStore}) : super();

  bool shuffuleEnabled = false;
  List<Audio> _currentChildren = [];
  List<HistoryAudio> _historyAudios = [];

  String get currentAudioPath {
    return _currentChildren[state.value?.currentIndex ?? 0].path;
  }

  List<HistoryAudio> get historyAudios {
    return _historyAudios;
  }

  int get currentIndex {
    return state.value?.currentIndex ?? 0;
  }

  Future<void> initialize(String audioPath) async {
    if (state.value != null && currentAudioPath == audioPath) return;
    await disposePlayer();
    await _registerAudioToFuture([audioPath]);
    state = AsyncValue.data(JustAudioDatasource());
    _currentChildren = [Audio(path: audioPath)];
    await state.value?.setAudioSource(sources: _currentChildren);
    state.value?.play();
  }

  Future<void> initializePlaylist(List<String> audioPaths) async {
    await disposePlayer();
    _currentChildren = audioPaths.map((e) => Audio(path: e)).toList();
    await _registerAudioToFuture(audioPaths);
    state = AsyncValue.data(JustAudioDatasource());
    await state.value?.setAudioSource(sources: _currentChildren);
    await state.value?.setShuffledEnabled(shuffuleEnabled);
    state.value?.play();
  }

  Future<void> disposePlayer() async {
    await state.value?.stop();
    await state.value?.dispose();
    state = const AsyncValue.data(null);
    _currentChildren = [];
  }

  void toggleShuffuleMode() async {
    shuffuleEnabled = !state.value!.shuffleEnabled;
    state.value!.setShuffledEnabled(shuffuleEnabled);
  }

  // @override
  // void dispose() {
  //   disposePlayer();
  //   super.dispose();
  // }

  @override
  FutureOr<AudioPlayerRepo?> build() async {
    final audiosString = await keyValueStore.getString(key: historyAudiosKey);
    if (audiosString == null) return null;
    final audiosListString = json.decode(audiosString) as List<dynamic>;
    _historyAudios = audiosListString.map((e) => HistoryAudio.fromJson(e)).toList();
    return null;
  }

  Future<void> _registerAudioToFuture(List<String> audioPaths) async {
    final transformedAudios = audioPaths
        .map((e) => HistoryAudio(audioPath: e, lastPlayed: DateTime.now()));
    while (_historyAudios.length >= 30) {
      _historyAudios.removeLast();
    }
    _historyAudios = [...transformedAudios, ..._historyAudios];
    final historyAudiosMapString = _historyAudios.map((e) => e.toJson()).toList();
    await keyValueStore.setString(
      key: historyAudiosKey,
      value: json.encode(historyAudiosMapString),
    );
  }
}

final audioPlayerProvider =
    AsyncNotifierProvider<AudioPlayerProvider, AudioPlayerRepo?>(() {
  return AudioPlayerProvider(
    keyValueStore: SharedPreferencesDatasource(),
  );
});
