import 'package:beatz/src/presentation/controllers/playlist_provider.dart';
import 'package:beatz/src/presentation/screens/playlist/widgets/playlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistScreen extends ConsumerWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(context, ref) {
    final allPlaylist = ref.watch(playlistProvider);

    return allPlaylist.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text("Failed to fetch playlist"),
      ),
      data: (playlistData) {
        if (playlistData.isEmpty) {
          return const Center(
            child: Text('No playlist created'),
          );
        }

        return ListView.builder(
          itemCount: playlistData.length,
          itemBuilder: (context, index) {
            final playlist = playlistData[index];
            return PlaylistTile(playlist);
          },
        );
      },
    );
  }
}
