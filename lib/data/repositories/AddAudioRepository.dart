import 'package:hafez_elmetoon/data/local/AudioSQLiteDB/AudioSqliteDB.dart';
import '../../screens/Models/AudioItem.dart';
import '../local/AudioFloorDB/LocalDB.dart';
import '../local/AudioFloorDB/RecordDao.dart';
import '../local/AudioFloorDB/Record.dart';
import '../local/models/AudioModel.dart';


abstract class CustomAudioRepository {
  Future<List<AudioEntity>> getAllCustomAudios();

  Future<void> addCustomAudio(AudioItem item);

  Future<void> deleteCustomAudio(int id);
}
class CustomAudioRepositoryImpl implements CustomAudioRepository {
  RecordDao? _dao;

  CustomAudioRepositoryImpl._internal();

  static Future<CustomAudioRepositoryImpl> create() async {
    final repository = CustomAudioRepositoryImpl._internal();
    await repository._initializeLocalDB();
    return repository;
  }

  Future<void> _initializeLocalDB() async {
    final localDB = await LocalDB.getInstance();
    _dao = localDB.recordDao;
  }


  // Getter to ensure dao is initialized
  Future<RecordDao> get dao async {
    if (_dao == null) {
      await _initializeLocalDB();
    }
    return _dao!;
  }

  @override
  Future<List<AudioEntity>> getAllCustomAudios() async {
    final recordDao = await dao;
    return (await recordDao.getAllRecords())
        .map((record) => AudioEntity(
      id: record.id,
      title: record.title,
      date: record.date,
      path: record.path,
    ))
        .toList();
  }

  @override
  Future<void> addCustomAudio(AudioItem entity) async {
    final recordDao = await dao;
    await recordDao.insertRecord(
        Record(title: entity.title, path: entity.path, date: entity.date));
  }

  @override
  Future<void> deleteCustomAudio(int id) async {
    final recordDao = await dao;
    await recordDao.deleteRecordById(id);
  }
}