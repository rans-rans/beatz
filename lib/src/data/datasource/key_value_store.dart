abstract class KeyValueStore {
  Future<bool?> getBool({
    required String key,
  });
  Future<String?> getString({
    required String key,
  });
  Future<void> setBool({
    required String key,
    required bool value,
  });
  Future<void> setString({
    required String key,
    required String value,
  });
}
