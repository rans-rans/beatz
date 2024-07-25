import 'dart:async';

import 'package:beatz/src/data/repositories/audios_repo_impl.dart';
import 'package:beatz/src/domain/entities/models/audio.dart';
import 'package:beatz/src/domain/repositories/audios_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllAudiosProvider extends AsyncNotifier<List<Audio>> {
  final AudiosRepository _audiosRepository;

  AllAudiosProvider(this._audiosRepository);

  @override
  FutureOr<List<Audio>> build() async {
    final audios = await _audiosRepository.fetchAllStorageAudios();
    return audios;
  }

  Future<void> reloadAudios() async {
    state = const AsyncValue.loading();
    final audios = await _audiosRepository.fetchAllStorageAudios();
    state = AsyncValue.data(audios);
  }
}

final allAudiosProvider = AsyncNotifierProvider<AllAudiosProvider, List<Audio>>(() {
  return AllAudiosProvider(AudiosRepoImpl());
});
