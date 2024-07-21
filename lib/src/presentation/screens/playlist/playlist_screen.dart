import 'package:beatz/src/domain/entities/collection.dart';
import 'package:beatz/src/presentation/controllers/playlist_provider.dart';
import 'package:beatz/src/presentation/shared/screens/collection_audios_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistScreen extends ConsumerWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(context, ref) {
    final allPlaylist = ref.watch(playlistProvider);
    return ListView.builder(
      itemCount: allPlaylist.length,
      itemBuilder: (context, index) {
        if (allPlaylist.isEmpty) {
          return const Center(
            child: Text('No playlist created'),
          );
        }
        final playlist = allPlaylist[index];
        return ListTile(
          title: Text(playlist.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CollectionAudiosScreen(
                  collection: Collection(
                    id: playlist.id,
                    name: playlist.name,
                    audios: playlist.audios,
                  ),
                ),
              ),
            );
          },
          subtitle: Text(
            playlist.audios.length.toString(),
          ),
        );
      },
    );
  }
}
