import 'dart:io';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerProvider extends StateNotifier<AudioPlayer?> {
  AudioPlayerProvider() : super(null);

  bool shuffuleEnabled = false;
  String _currentAudioPath = '';
  String get currentAudioPath => _currentAudioPath;

  Future<void> initialize(String audioPath) async {
    if (state != null && _currentAudioPath == audioPath) return;
    _currentAudioPath = audioPath;
    disposePlayer();
    final metadata = await readMetadata(File(audioPath));
    state = AudioPlayer();
    await state?.setShuffleModeEnabled(shuffuleEnabled);
    await state?.setAudioSource(
      AudioSource.file(
        audioPath,
        tag: MediaItem(
          id: audioPath,
          title: metadata.title ?? getFileName(audioPath),
          album: metadata.album ?? "Unknown album",
          duration: metadata.duration,
          artist: metadata.album ?? "No artist",
        ),
      ),
    );
    state?.play();
  }

  Future<void> initializePlaylist(List<String> audioPaths) async {
    await disposePlayer();
    _currentAudioPath = '';
    final children = audioPaths
        .map(
          (s) => AudioSource.file(
            s,
            tag: MediaItem(
              id: s,
              title: getFileName(s),
              displayTitle: getFileName(s),
            ),
          ),
        )
        .toList();
    final audioSource = ConcatenatingAudioSource(children: children);
    state = AudioPlayer();

    await state?.setShuffleModeEnabled(shuffuleEnabled);
    await state?.setAudioSource(audioSource);
    state?.play();
  }

  Future<void> disposePlayer() async {
    await state?.dispose();
    state = null;
  }

  void toggleShuffuleMode() {
    shuffuleEnabled = !state!.shuffleModeEnabled;
    state!.setShuffleModeEnabled(shuffuleEnabled);
  }

  @override
  void dispose() {
    disposePlayer();
    super.dispose();
  }
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerProvider, AudioPlayer?>((ref) {
  return AudioPlayerProvider();
});

enum AudioViewState { minimized, dismissed }
