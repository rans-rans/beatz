import 'package:beatz/src/presentation/controllers/all_audio_provider.dart';
import 'package:beatz/src/presentation/shared/widgets/audio_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllAudiosScreen extends ConsumerWidget {
  const AllAudiosScreen({super.key});

  @override
  Widget build(context, ref) {
    final allAudios = ref.watch(allAudiosProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.read(allAudiosProvider.notifier).reloadAudios();
      },
      child: allAudios.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
          child: Text("No audios found"),
        ),
        data: (audios) {
          return ListView.builder(
            itemCount: audios.length,
            itemBuilder: (context, index) {
              final audio = audios[index];
              return AudioTile(audio);
            },
          );
        },
      ),
    );
  }
}
