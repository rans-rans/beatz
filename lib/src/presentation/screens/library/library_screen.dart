import 'package:beatz/src/presentation/screens/album/all_albums_screen.dart';
import 'package:beatz/src/presentation/screens/all%20songs/all_audios_screen.dart';
import 'package:beatz/src/presentation/screens/playlist/playlist_screen.dart';
import 'package:flutter/material.dart';

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
          bottom: const TabBar(tabs: [
            Tab(child: Text("All Songs")),
            Tab(child: Text("Albums")),
            Tab(child: Text("Playlists")),
          ]),
        ),
        body: const TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
