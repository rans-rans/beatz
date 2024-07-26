import 'dart:async';

import 'package:beatz/src/data/repositories/sql_lite_playlist_repo.dart';
import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/domain/repositories/playlist_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistProvider extends AsyncNotifier<List<Collection>> {
  final PlaylistRepository _playlistRepo;
  PlaylistProvider(this._playlistRepo) : super();

  void addToPlaylist(String path, String playlistId) async {
    if (state.value != null) {
      final index = state.value!.indexWhere((playlist) => playlist.id == playlistId);
      state.value![index].audios.add(path);
      await _playlistRepo.addAudioToPlaylist(
        playlistId: playlistId,
        audioPath: path,
      );
    }
  }

  void addPlaylist(String name, List<String> audios) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    state.value!.add(Collection(
      id: id,
      name: name,
      audios: audios,
    ));
    await _playlistRepo.addAudioToPlaylist(playlistId: id, audioPath: audios.first);
    await _playlistRepo.createPlaylist(id: id, name: name);
  }

  Future<void> deletePlaylist(String id) async {
    final index = state.value!.indexWhere((playlist) => playlist.id == id);
    if (state.value != null) {
      state.value!.removeAt(index);
      state = AsyncData(state.value!);
      await _playlistRepo.deletePlaylist(id: id);
    }
  }

  void removeFromPlaylist(String path, String playlistId) async {
    if (state.value != null) {
      final index = state.value!.indexWhere((e) => e.id == playlistId);
      state.value![index].audios.remove(path);
      await _playlistRepo.removeAudioFromPlaylist(
          playlistId: playlistId, audioPath: path);
    }
  }

  @override
  FutureOr<List<Collection>> build() async {
    final storagePlaylist = await _playlistRepo.fetchAllPlaylist();
    return storagePlaylist;
  }
}

final playlistProvider =
    AsyncNotifierProvider<PlaylistProvider, List<Collection>>(() {
  return PlaylistProvider(SqlLitePlaylistRepo());
});
