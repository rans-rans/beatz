import 'dart:io';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:beatz/shared/helpers/helper_functions.dart';
import 'package:beatz/src/presentation/shared/components/add_to_playlist_sheet.dart';
import 'package:flutter/material.dart';

Future showAudioInfoSheet(BuildContext context, String audioPath) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => AudioInfoSheet(audioPath: audioPath),
  );
}

class AudioInfoSheet extends StatelessWidget {
  final String audioPath;
  const AudioInfoSheet({super.key, required this.audioPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.playlist_add),
            title: const Text("Add to playlist"),
            onTap: () {
              Navigator.pop(context);
              showAddToPlaylistSheet(context, audioPath);
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
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        FutureBuilder(
                          future: readMetadata(File(audioPath)),
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) return const SizedBox.shrink();
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Name: ${data.title ?? getFileName(audioPath)}",
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Album: ${data.album ?? "Unknown album"}",
                                  ),
                                ),
                                ListTile(title: Text("Destination: $audioPath")),
                                ListTile(
                                  title: Text(
                                    "Duration: ${data.duration?.inSeconds ?? 0} seconds",
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
