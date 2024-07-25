import 'package:beatz/src/presentation/controllers/all_audio_provider.dart';
import 'package:beatz/src/presentation/screens/album/all_albums_screen.dart';
import 'package:beatz/src/presentation/screens/all%20songs/all_audios_screen.dart';
import 'package:beatz/src/presentation/screens/playlist/playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      AllAudiosScreen(),
      AllAlbumsScreen(),
      PlaylistScreen(),
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Tab(child: Text("All Songs")),
                Consumer(
                  builder: (context, ref, child) {
                    final audios = ref.watch(allAudiosProvider);

                    return audios.whenData(
                          (data) {
                            return Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                data.length.toString(),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            );
                          },
                        ).value ??
                        const SizedBox.shrink();
                  },
                )
              ],
            ),
            const Tab(child: Text("Albums")),
            const Tab(child: Text("Playlists")),
          ]),
        ),
        body: const TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
