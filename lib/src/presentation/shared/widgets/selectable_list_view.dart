import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/features/audio_player/presentation/contollers/audio_player_provider.dart';
import 'package:beatz/src/presentation/controllers/audio_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectableListView<T> extends ConsumerWidget {
  final List<Audio> audioItems;
  final Widget? leading;
  final Widget? Function(int index)? title;
  final Widget? Function(int index)? subtitle;
  final Widget? Function(int index)? trailing;
  final Function(int)? onTap;

  const SelectableListView({
    super.key,
    required this.audioItems,
    this.onTap,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(context, ref) {
    List<int> highlightedAudios = [];
    final screenSize = MediaQuery.sizeOf(context);
    return StatefulBuilder(builder: (context, setState) {
      if (audioItems.isEmpty) {
        return const Center(
          child: Text('No data available'),
        );
      }
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          ListView.builder(
            itemCount: audioItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: leading,
                selected: highlightedAudios.contains(index),
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                title: switch (title == null) {
                  true => null,
                  false => title!(index)
                },
                subtitle: switch (subtitle == null) {
                  true => null,
                  false => subtitle!(index)
                },
                trailing: switch (trailing == null) {
                  true => null,
                  false => trailing!(index)
                },
                onTap: switch (onTap == null) {
                  true => null,
                  false => () {
                      onTap!(index);
                    },
                },
                onLongPress: () {
                  if (highlightedAudios.contains(index)) {
                    highlightedAudios.remove(index);
                  } else {
                    highlightedAudios.add(index);
                  }
                  setState(() {});
                },
              );
            },
          ),
          if (highlightedAudios.isNotEmpty)
            Positioned(
              bottom: screenSize.height * 0.02,
              right: screenSize.height * 0.02,
              child: FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () {
                  final selectedAudios =
                      highlightedAudios.map((e) => audioItems[e].path).toList();
                  highlightedAudios = [];
                  setState(() {});
                  ref
                      .read(audioPlayerProvider.notifier)
                      .initializePlaylist(selectedAudios);
                  ref.read(audioViewProvider.notifier).minimizePlayer();
                },
              ),
            )
        ],
      );
    });
  }
}
