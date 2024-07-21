import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnAudioQuery().queryPlaylists(orderType: OrderType.ASC_OR_SMALLER),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final playlists = snapshot.data ?? [];
        if (playlists.isEmpty) {
          return const Center(
            child: Text('No playlist created'),
          );
        }
        return ListView.builder(
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return ListTile(
              title: Text(playlist.playlist),
              subtitle: Text(playlist.numOfSongs.toString()),
            );
          },
        );
      },
    );
  }
}
