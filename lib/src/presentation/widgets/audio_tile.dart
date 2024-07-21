import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioTile extends ConsumerWidget {
  final SongModel audio;
  const AudioTile(this.audio, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(audio.title),
      leading: const Icon(Icons.music_note),
      onTap: () {
        ref.read(audioPlayerProvider.notifier).initialize(audio.data).then((_) {
          Navigator.push(
            context,
            NavigateToMusicPlayerAnimation(),
          ).then((_) {
            ref.read(audioViewProvider.notifier).minimizePlayer();
          });
        });
      },
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      ),
    );
  }
}
