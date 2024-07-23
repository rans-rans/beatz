import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/screens/album/widgets/album_songs_list.dart';
import 'package:beatz/src/presentation/shared/widgets/minimized_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionAudiosScreen extends ConsumerWidget {
  final Collection collection;
  const CollectionAudiosScreen({super.key, required this.collection});

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      floatingActionButton: StreamBuilder<bool>(
          stream: ref.watch(audioPlayerProvider)?.musicActiveStream,
          builder: (context, musicActiveSnapshot) {
            return StreamBuilder<bool>(
              stream: ref.read(audioPlayerProvider)?.listenToPlayingState,
              builder: (context, playingSnapshot) {
                final musicActive = musicActiveSnapshot.data;
                final isPlaying = playingSnapshot.data;

                // final nothingPlaying = (musicActive == null && isPlaying == null);
                final audioPaused = musicActive == true && isPlaying == false;
                final audioPlaying = musicActive == true && isPlaying == true;
                if (audioPaused || audioPlaying) {
                  return const SizedBox.shrink();
                }
                return FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () {
                    ref
                        .read(audioPlayerProvider.notifier)
                        .initializePlaylist(collection.audios)
                        .then((_) {
                      ref.read(audioViewProvider.notifier).minimizePlayer();
                    });
                  },
                );
              },
            );
          }),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CollectionAudiosList(collection: collection),
          const MinimizedPlayer(),
        ],
      ),
    );
  }
}
