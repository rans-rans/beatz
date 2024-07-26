import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/playlist_provider.dart';
import 'package:beatz/src/presentation/shared/screens/collection_audios_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistTile extends ConsumerWidget {
  final Collection playlist;
  const PlaylistTile(this.playlist, {super.key});

  @override
  Widget build(context, ref) {
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
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            useSafeArea: true,
            builder: (_) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.play_arrow_rounded),
                    title: const Text("Play"),
                    onTap: () {
                      //start the playlist
                      ref
                          .read(audioPlayerProvider.notifier)
                          .initializePlaylist(playlist.audios);
                      //remove the bottom sheet
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About"),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 175,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Text('Playlist name:'),
                                    title: Text(playlist.name),
                                  ),
                                  ListTile(
                                    leading: const Text('Content length:'),
                                    title:
                                        Text("${playlist.audios.length} element(s)"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_forever),
                    title: const Text("Delete playlist"),
                    onTap: () {
                      //remove the playlist bottom sheet
                      Navigator.pop(context);
                      //show the delete dialog
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Confirm delete'),
                          content: const SizedBox(
                            height: 150,
                            child: Text(
                              "Are you sure you want to delete this playlist",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                ref
                                    .read(playlistProvider.notifier)
                                    .deletePlaylist(playlist.id);
                                Navigator.pop(context);
                              },
                              child: const Text("yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("NO"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
