import 'package:beatz/src/presentation/widgets/audio_tile.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final audioQuery = OnAudioQuery();
    return FutureBuilder(
      future: audioQuery.checkAndRequest(),
      builder: (contex, snap) {
        return FutureBuilder(
          future: audioQuery.querySongs(),
          builder: (context, querySnapshot) {
            if (querySnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if ((querySnapshot.data ?? []).isEmpty) {
              return const Center(
                child: Text("No audios found"),
              );
            }
            return ListView.builder(
              itemCount: querySnapshot.data!.length,
              itemBuilder: (context, index) {
                final audio = querySnapshot.data![index];
                return AudioTile(audio);
              },
            );
          },
        );
      },
    );
  }
}
