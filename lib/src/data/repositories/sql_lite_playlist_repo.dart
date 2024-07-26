import 'package:beatz/src/data/datasource/sql_lite_db.dart';
import 'package:beatz/src/domain/entities/models/collection.dart';
import 'package:beatz/src/domain/repositories/playlist_repo.dart';

class SqlLitePlaylistRepo implements PlaylistRepository {
  final sqlDB = DatabaseHelper();
  @override
  Future<void> addAudioToPlaylist(
      {required String playlistId, required String audioPath}) async {
    await sqlDB.insertAudioIntoPlaylist(playlistId, audioPath);
  }

  @override
  Future<void> createPlaylist({
    required String id,
    required String name,
  }) async {
    await sqlDB.insertPlaylist({'id': id, 'name': name});
  }

  @override
  Future<void> deletePlaylist({required String id}) async {
    await sqlDB.deletePlaylist(id);
  }

  @override
  Future<void> removeAudioFromPlaylist(
      {required String playlistId, required String audioPath}) async {
    await sqlDB.removeAudioFromPlaylist(playlistId, audioPath);
  }

  @override
  Future<void> renamePlaylist({required String id, required String newName}) async {
    await sqlDB.updatePlaylist(id, newName);
  }

  @override
  Future<List<String>> fetchPlaylistAudios(String id) async {
    final audios = await sqlDB.queryPlaylistAudio(id);
    final data = audios.map((e) => e['audio_path'] as String);
    return data.toList();
  }

  @override
  Future<List<Collection>> fetchAllPlaylist() async {
    final data = await sqlDB.queryAllPlaylists();
    final playlists = data.map((e) {
      return Collection(
        id: e['id'],
        name: e['name'],
        audios: [],
      );
    }).toList();
    for (var i = 0; i < playlists.length; i++) {
      final audios = await sqlDB.queryPlaylistAudio(playlists[i].id);
      playlists[i].audios = audios.map((e) => e['audio_path'] as String).toList();
    }
    return playlists;
  }
}
