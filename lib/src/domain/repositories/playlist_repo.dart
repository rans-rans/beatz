import 'package:beatz/src/domain/entities/models/collection.dart';

abstract class PlaylistRepository {
  Future<void> createPlaylist({required String id, required String name});
  Future<void> addAudioToPlaylist({
    required String playlistId,
    required String audioPath,
  });
  Future<void> deletePlaylist({required String id});
  Future<List<Collection>> fetchAllPlaylist();
  Future<void> renamePlaylist({required String id, required String newName});
  Future<void> removeAudioFromPlaylist({
    required String playlistId,
    required String audioPath,
  });

  Future<List<String>> fetchPlaylistAudios(String id);
}
