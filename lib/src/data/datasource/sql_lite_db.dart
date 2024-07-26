import 'package:beatz/shared/constants/database_variable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $playlistTable(id TEXT PRIMARY KEY, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE $playlistAudiosTable(playlist_id TEXT, audio_path TEXT)',
    );
  }

  // CRUD operations for playlists
  Future<int> insertPlaylist(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('playlists', row);
  }

  Future<int> insertAudioIntoPlaylist(
    String playlistId,
    String audioPath,
  ) async {
    Database db = await database;
    return await db.insert('playlists_audio', {
      'audio_path': audioPath,
      'playlist_id': playlistId,
    });
  }

  Future<int> removeAudioFromPlaylist(String playlistId, String audioPath) async {
    Database db = await database;
    return await db.delete(
      'playlists_audio',
      where: 'playlist_id = ? and path = ?',
      whereArgs: [playlistId, audioPath],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllPlaylists() async {
    Database db = await database;
    return await db.query('playlists');
  }

  Future<List<Map<String, dynamic>>> queryPlaylistAudio(String id) async {
    Database db = await database;
    return await db.query(
      'playlists_audio',
      where: 'playlist_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePlaylist(String playlistId, String newName) async {
    Database db = await database;
    return await db.update(
      'playlists',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [playlistId],
    );
  }

  Future<int> deletePlaylist(String id) async {
    Database db = await database;
    await db.delete('playlists_audio', where: 'playlist_id = ?', whereArgs: [id]);
    return await db.delete('playlists', where: 'id = ?', whereArgs: [id]);
  }
}
