import 'package:beatz/src/presentation/shared/widgets/audio_tile.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllAudiosScreen extends StatefulWidget {
  const AllAudiosScreen({super.key});

  @override
  State<AllAudiosScreen> createState() => _AllAudiosScreenState();
}

class _AllAudiosScreenState extends State<AllAudiosScreen> {
  final audioQuery = OnAudioQuery();
  late Future<List<SongModel>> fetchAudios;

  @override
  void initState() {
    super.initState();
    fetchAudios = audioQuery.querySongs();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          fetchAudios = audioQuery.querySongs();
        });
      },
      child: FutureBuilder(
        future: audioQuery.checkAndRequest(),
        builder: (contex, snap) {
          return FutureBuilder(
            future: fetchAudios,
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
      ),
    );
  }
}
