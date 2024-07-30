import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionAudiosList extends ConsumerWidget {
  final Collection collection;
  const CollectionAudiosList({super.key, required this.collection});

  @override
  Widget build(context, ref) {
    return ListView.builder(
      itemCount: collection.audios.length,
      itemBuilder: (context, index) {
        final audioPath = collection.audios[index];
        return ListTile(
          title: Text(getFileName(audioPath)),
          onTap: () async {
            ref.read(audioPlayerProvider.notifier).initialize(audioPath).then(
              (_) async {
                Navigator.push(context, NavigateToMusicPlayerAnimation()).then(
                  (_) {
                    ref.read(audioViewProvider.notifier).minimizePlayer();
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
