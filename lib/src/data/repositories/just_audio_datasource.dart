import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/domain/entities/enums/shuffle_mode.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/domain/repositories/audio_player_repo.dart';

class JustAudioDatasource implements AudioPlayerRepo {
  final player = AudioPlayer();

  @override
  int get currentIndex => player.currentIndex ?? 0;

  @override
  Future<void> dispose() async {
    return await player.dispose();
  }

  @override
  Duration get getAudioLength {
    return player.duration ?? Duration.zero;
  }

  @override
  bool get musicActive {
    final state = player.playerState.processingState;
    return state == ProcessingState.buffering || state == ProcessingState.ready;
  }

  @override
  bool get isPlaying {
    return player.playing;
  }

  @override
  Stream<bool> get listenToPlayingState {
    return player.playerStateStream.map((e) => e.playing);
  }

  @override
  Stream<Duration> get listenToPosition {
    return player.positionStream;
  }

  @override
  Stream<bool> get listenToShuffle {
    return player.shuffleModeEnabledStream;
  }

  @override
  Stream<bool> get musicActiveStream {
    return player.playerStateStream.map((data) {
      final state = data.processingState;
      return state == ProcessingState.buffering || state == ProcessingState.ready;
    });
  }

  @override
  Loopmode get loopMode {
    return switch (player.loopMode) {
      LoopMode.off => Loopmode.off,
      LoopMode.one => Loopmode.one,
      LoopMode.all => Loopmode.all,
    };
  }

  @override
  bool get shuffleEnabled => player.shuffleModeEnabled;

  @override
  Future<void> pause() async {
    return await player.pause();
  }

  @override
  Future<void> play() async {
    return await player.play();
  }

  @override
  Future<void> seekToPosition(Duration position) async {
    return await player.seek(position);
  }

  @override
  Future<void> setAudioSource({
    required List<Audio> sources,
  }) async {
    final children = sources.map(
      (source) {
        return AudioSource.file(source.path,
            tag: MediaItem(
              id: source.path,
              title: source.title ?? getFileName(source.path),
            ));
      },
    ).toList();
    await player.setAudioSource(ConcatenatingAudioSource(children: children));
  }

  @override
  Future<void> setLoopMode(Loopmode shuffleMode) {
    final loopmode = switch (shuffleMode) {
      Loopmode.off => LoopMode.off,
      Loopmode.one => LoopMode.one,
      Loopmode.all => LoopMode.all,
    };
    return player.setLoopMode(loopmode);
  }

  @override
  Future<void> setShuffledEnabled(bool shuffleEnabled) async {
    return await player.setShuffleModeEnabled(shuffleEnabled);
  }

  @override
  Future<void> skipToNext() async {
    return await player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    return await player.seekToPrevious();
  }

  @override
  Future<void> stop() async {
    return await player.stop();
  }
}
