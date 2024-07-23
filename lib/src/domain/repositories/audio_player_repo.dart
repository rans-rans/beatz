import 'package:beatz/src/domain/entities/enums/shuffle_mode.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';

abstract class AudioPlayerRepo {
  int get currentIndex;
  Duration get getAudioLength;
  bool get isPlaying;
  Loopmode get loopMode;
  bool get shuffleEnabled;

  Future<void> play();
  Future<void> pause();
  Future<void> dispose();
  Future<void> setShuffledEnabled(bool shuffleEnabled);
  Future<void> setAudioSource({required List<Audio> sources});
  Future<void> setLoopMode(Loopmode shuffleMode);
  Future<void> seekToPosition(Duration position);
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> stop();

  Stream<Duration> get listenToPosition;
  Stream<bool> get listenToShuffle;
  Stream<bool> get listenToPlayingState;
}
