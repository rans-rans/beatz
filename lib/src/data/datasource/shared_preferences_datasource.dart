import 'package:beatz/src/data/datasource/key_value_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource implements KeyValueStore {
  static SharedPreferences? _instance;

  Future<SharedPreferences> get instance async {
    if (_instance != null) return _instance!;
    _instance = await SharedPreferences.getInstance();
    return _instance!;
  }

  @override
  Future<bool?> getBool({required String key}) async {
    final db = await instance;
    final data = db.getBool(key);
    return data;
  }

  @override
  Future<String?> getString({required String key}) async {
    final db = await instance;
    final data = db.getString(key);
    return data;
  }

  @override
  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    final db = await instance;
    await db.setBool(key, value);
  }

  @override
  Future<void> setString({
    required String key,
    required String value,
  }) async {
    final db = await instance;
    await db.setString(key, value);
  }
}
