import 'package:floor/floor.dart';
import 'RecordDao.dart';
import 'Record.dart';  // Make sure this path is correct
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'AppDatabase.g.dart'; // same current file name

@Database(version: 1, entities: [Record])
abstract class AppDatabase extends FloorDatabase {
  RecordDao get recordDao;
}
