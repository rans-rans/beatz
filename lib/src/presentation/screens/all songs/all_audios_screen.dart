import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/all_audio_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/shared/components/audio_info_sheet.dart';
import 'package:beatz/src/presentation/shared/widgets/selectable_list_view.dart';
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
          child: Text("Errour fetching audios"),
        ),
        data: (audios) {
          // return ListView.builder(
          //   itemCount: audios.length,
          //   itemBuilder: (context, index) {
          //     final audio = audios[index];
          //     return AudioTile(audio);
          //   },
          // );

          return SelectableListView(
            audioItems: audios,
            title: (index) {
              final audio = audios[index];
              return Text(
                audio.title ?? getFileName(audio.path),
                maxLines: 2,
              );
            },
            leading: const Icon(Icons.music_note),
            onTap: (index) {
              final audio = audios[index];
              ref
                  .read(audioPlayerProvider.notifier)
                  .initialize(audio.path)
                  .then((_) {
                Navigator.push(
                  context,
                  NavigateToMusicPlayerAnimation(),
                ).then((_) {
                  ref.read(audioViewProvider.notifier).minimizePlayer();
                });
              });
            },
            trailing: (index) {
              final audio = audios[index];
              return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showAudioInfoSheet(context, audio.path);
                },
              );
            },
          );
        },
      ),
    );
  }
}
