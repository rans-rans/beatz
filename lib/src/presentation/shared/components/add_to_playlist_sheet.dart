import 'package:beatz/src/presentation/controllers/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future showAddToPlaylistSheet(BuildContext context, String path) async {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    enableDrag: true,
    builder: (_) => _AddToPlaylistBody(path),
  );
}

class _AddToPlaylistBody extends ConsumerStatefulWidget {
  final String path;
  const _AddToPlaylistBody(this.path);

  @override
  ConsumerState<_AddToPlaylistBody> createState() => _AddToPlaylistBodyState();
}

class _AddToPlaylistBodyState extends ConsumerState<_AddToPlaylistBody> {
  final playlistnameCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    playlistnameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playlistNotifier = ref.read(playlistProvider.notifier);
    final playlistProv = ref.read(playlistProvider);

    return DraggableScrollableSheet(
      shouldCloseOnMinExtent: true,
      expand: false,
      builder: (context, scrollCtrl) => Padding(
        padding: const EdgeInsets.only(
          right: 8,
          left: 8,
          // bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: playlistnameCtrl,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextButton(
                  child: const Text('SAVE'),
                  onPressed: () {
                    if (playlistnameCtrl.text.isEmpty) return;
                    playlistNotifier
                        .addPlaylist(playlistnameCtrl.text, [widget.path]);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Flexible(
                child: switch (playlistProv.isEmpty) {
              true => const Center(child: Text('No playlist created yet')),
              false => ListView.builder(
                  itemCount: playlistProv.length,
                  primary: false,
                  itemBuilder: (context, index) {
                    final playlist = playlistProv[index];
                    return ListTile(
                      title: Text(playlist.name),
                      onTap: () {
                        playlistNotifier.addToPlaylist(widget.path, playlist.id);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
            }),
          ],
        ),
      ),
    );
  }
}
