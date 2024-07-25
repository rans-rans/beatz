import 'package:beatz/src/domain/entities/models/audio.dart';

abstract class AudiosRepository {
  Future<List<Audio>> fetchAllStorageAudios();
}
