import 'dart:io';

import 'package:beatz/shared/animations/page_animations/navigate_to_music_player_animation.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  Directory currentDirectory = Directory('/storage/emulated/0');
  List<FileSystemEntity> systemEntities = [];
  String homePath = '/storage/emulated/0';

  Future<void> getFiles() async {
    if (await currentDirectory.exists() == false) {
      return;
    }
    systemEntities = currentDirectory.listSync()
      ..sort((a, b) => getFileName(a.path).compareTo(getFileName(b.path)));
  }

  bool get isHomeDirectory => currentDirectory.path == homePath;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isHomeDirectory,
      onPopInvoked: (didPop) {
        if (!didPop) {
          currentDirectory = currentDirectory.parent;
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(getFileName(currentDirectory.path)),
          leading: switch (isHomeDirectory) {
            true => null,
            false => IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (homePath != currentDirectory.path) {
                    currentDirectory = currentDirectory.parent;
                    setState(() {});
                  }
                },
              )
          },
        ),
        body: FutureBuilder(
          future: getFiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: systemEntities.length,
              itemBuilder: (context, index) {
                final fileItem = systemEntities[index];
                return Consumer(
                  builder: (context, ref, child) {
                    return ListTile(
                      leading: Icon(switch (fileItem is File) {
                        true => isMusicFile(fileItem.path)
                            ? Icons.music_note
                            : Icons.file_open,
                        false => Icons.folder,
                      }),
                      title: Text(getFileName(fileItem.path)),
                      onTap: () {
                        fileItem.stat().then(
                          (stat) async {
                            if (stat.type == FileSystemEntityType.directory) {
                              currentDirectory = fileItem as Directory;
                              setState(() {});
                            }
                            if (isMusicFile(fileItem.path)) {
                              ref
                                  .read(audioPlayerProvider.notifier)
                                  .initialize(fileItem.path)
                                  .then((_) async {
                                await Navigator.push(
                                    context, NavigateToMusicPlayerAnimation());
                                ref
                                    .read(audioViewProvider.notifier)
                                    .minimizePlayer();
                              });
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
