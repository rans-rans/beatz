import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/domain/repositories/audios_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudiosRepoImpl implements AudiosRepository {
  @override
  Future<List<Audio>> fetchAllStorageAudios() async {
    final fetchedAudios = await OnAudioQuery().querySongs();
    final data = fetchedAudios.map(
      (e) => Audio(
        path: e.data,
        album: e.album,
        artist: e.artist,
        duration: Duration(seconds: e.duration ?? 0),
        title: e.displayName,
      ),
    );
    return data.toList();
  }
}
