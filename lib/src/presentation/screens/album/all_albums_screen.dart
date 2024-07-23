import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:beatz/src/presentation/shared/screens/collection_audios_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllAlbumsScreen extends ConsumerWidget {
  const AllAlbumsScreen({super.key});

  @override
  Widget build(context, ref) {
    return FutureBuilder(
        future: OnAudioQuery().queryAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            itemCount: (snapshot.data ?? []).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              mainAxisExtent: 200,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final album = snapshot.data![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () async {
                          OnAudioQuery()
                              .queryAudiosFrom(AudiosFromType.ALBUM_ID, album.id)
                              .then((audios) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CollectionAudiosScreen(
                                  collection: Collection(
                                    id: album.id.toString(),
                                    name: album.album,
                                    audios: audios.map((e) => e.data).toList(),
                                  ),
                                ),
                              ),
                            );
                            ref.read(audioViewProvider.notifier).minimizePlayer();
                          });
                        },
                        child: const Center(
                          child: Icon(Icons.album),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    album.album,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              );
            },
          );
        });
  }
}
