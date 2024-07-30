import 'package:beatz/src/domain/entities/models/history_audio.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryProvider extends StateNotifier<List<HistoryAudio>> {
  final Ref ref;

  HistoryProvider(this.ref) : super([]) {
    ref.listen(
      audioPlayerProvider,
      (prev, next) {
        state = ref.read(audioPlayerProvider.notifier).historyAudios;
      },
    );
  }
}

final historyProvider =
    StateNotifierProvider<HistoryProvider, List<HistoryAudio>>((ref) {
  return HistoryProvider(ref);
});
