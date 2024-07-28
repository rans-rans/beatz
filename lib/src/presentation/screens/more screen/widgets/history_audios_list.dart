import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/screens/more%20screen/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryAudiosList extends ConsumerWidget {
  const HistoryAudiosList({super.key});

  @override
  Widget build(context, ref) {
    final audioPlayerProv = ref.watch(audioPlayerProvider);
    final audioPlayerNotifier = ref.watch(audioPlayerProvider.notifier);
    final history = audioPlayerNotifier.historyAudios;
    return audioPlayerProv.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text("Error fetching history"),
      ),
      data: (_) => SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("History"),
              Expanded(
                child: history.isEmpty
                    ? const Center(
                        child: Text("History is empty"),
                      )
                    : ListView.builder(
                        itemCount: history.length,
                        itemExtent: 200,
                        padding: const EdgeInsets.all(5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return DecoratedBox(
                            child: HistoryCard(historyAudio: history[index]),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
