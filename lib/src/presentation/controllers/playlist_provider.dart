import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistProvider extends StateNotifier<List<Collection>> {
  PlaylistProvider() : super([]);

  void addToPlaylist(String path, String playlistId) {
    final index = state.indexWhere((playlist) => playlist.id == playlistId);
    state[index].audios.add(path);
  }

  void addPlaylist(String name, List<String> audios) {
    state.add(Collection(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      audios: audios,
    ));
  }

  void deletePlaylist(String id) {
    state.removeWhere((e) => e.id == id);
  }

  void removeFromPlaylist(String path, String playlistId) {
    final index = state.indexWhere((e) => e.id == playlistId);
    state[index].audios.remove(path);
  }
}

final playlistProvider =
    StateNotifierProvider<PlaylistProvider, List<Collection>>((ref) {
  return PlaylistProvider();
});
