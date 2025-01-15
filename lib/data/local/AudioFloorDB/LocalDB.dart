

import 'AppDatabase.dart';
import 'RecordDao.dart';

class LocalDB {
  static LocalDB? _instance;
  late AppDatabase _database;

  LocalDB._internal();

  static Future<LocalDB> getInstance() async {
    if (_instance == null) {
      _instance = LocalDB._internal();
      await _instance!._initDatabase();
    }
    return _instance!;
  }

  Future<void> _initDatabase() async {
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  AppDatabase get database {
    if (_database == null) {
      throw Exception("Database is not initialized. Call getInstance() first.");
    }
    return _database;
  }

  RecordDao get recordDao => database.recordDao;
}
