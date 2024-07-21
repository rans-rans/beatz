import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/presentation/controllers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumSongsList extends ConsumerWidget {
  final int albumId;
  final Function(List<SongModel>) onAudio;
  const AlbumSongsList({
    super.key,
    required this.albumId,
    required this.onAudio,
  });

  @override
  Widget build(context, ref) {
    return FutureBuilder(
      future: OnAudioQuery().queryAudiosFrom(AudiosFromType.ALBUM_ID, albumId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        onAudio(snapshot.data ?? []);
        final audios = snapshot.data ?? [];

        return ListView.builder(
          itemCount: audios.length,
          itemBuilder: (context, index) {
            final song = audios[index];
            return ListTile(
              title: Text(song.title),
              subtitle: Text(
                song.displayNameWOExt,
                maxLines: 1,
              ),
              trailing: Text(
                getFormattedTime(Duration(milliseconds: song.duration ?? 0)),
              ),
              onTap: () async {
                ref.read(audioPlayerProvider.notifier).initialize(song.data).then(
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
      },
    );
  }
}
