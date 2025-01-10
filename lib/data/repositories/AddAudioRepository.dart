import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../screens/Models/AudioItem.dart';
import '../models/AudioItemDB.dart';

abstract class CustomAudioRepository {
  Future<List<AudioEntity>> getAllCustomAudios();
  Future<void> addCustomAudio(AudioItem item);
  Future<void> deleteCustomAudio(int id);
}
class CustomAudioRepositoryImpl implements CustomAudioRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'audio_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE audio(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            path TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<AudioEntity>> getAllCustomAudios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('audio');
    return List.generate(maps.length, (i) => StringItem.fromMap(maps[i]));
  }

  @override
  Future<void> addCustomAudio(AudioItem entity) async {
    final db = await database;
    final item = StringItem.fromEntity(AudioEntity.AudioEntity( title: entity.title, path: entity.path, date: entity.date));
    await db.insert('audio', item.toMap());
  }

  @override
  Future<void> deleteCustomAudio(int id) async {
    final db = await database;
    await db.delete(
      'audio',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
