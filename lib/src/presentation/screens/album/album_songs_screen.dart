import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/screens/album/widgets/album_songs_list.dart';
import 'package:beatz/src/presentation/widgets/minimized_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumSongsScreen extends ConsumerWidget {
  final AlbumModel albumModel;
  const AlbumSongsScreen({super.key, required this.albumModel});

  @override
  Widget build(context, ref) {
    List<SongModel> songs = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(albumModel.album),
      ),
      floatingActionButton: switch (ref.watch(audioPlayerProvider) != null) {
        true => const SizedBox.shrink(),
        false => FloatingActionButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () {
              ref
                  .read(audioPlayerProvider.notifier)
                  .initializePlaylist(songs.map((s) => s.data).toList())
                  .then((_) {
                ref.read(audioViewProvider.notifier).minimizePlayer();
              });
            },
          )
      },
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AlbumSongsList(
            albumId: albumModel.id,
            onAudio: (data) {
              songs = data;
            },
          ),
          const MinimizedPlayer(),
        ],
      ),
    );
  }
}
