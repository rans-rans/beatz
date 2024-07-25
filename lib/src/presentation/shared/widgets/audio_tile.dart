import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/shared/components/audio_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioTile extends ConsumerWidget {
  final Audio audio;
  const AudioTile(this.audio, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        audio.title ?? getFileName(audio.path),
        maxLines: 2,
      ),
      leading: const Icon(Icons.music_note),
      onTap: () {
        ref.read(audioPlayerProvider.notifier).initialize(audio.path).then((_) {
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
        onPressed: () {
          showAudioInfoSheet(context, audio.path);
        },
      ),
    );
  }
}
