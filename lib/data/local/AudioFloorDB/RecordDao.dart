import 'package:floor/floor.dart';
import 'Record.dart';  // Add this import


@dao
abstract class RecordDao {
  @Query('SELECT * FROM RECORDS')
  Future<List<Record>> getAllRecords();

  @Query('SELECT * FROM RECORDS WHERE id = :id')
  Future<Record?> getRecordById(int id);

  @insert
  Future<int> insertRecord(Record record);

  @update
  Future<int> updateRecord(Record record);

  @Query('DELETE FROM RECORDS WHERE id = :id')
  Future<void> deleteRecordById(int id);

  // Uncomment if needed
  // @delete
  // Future<int> deleteRecord(Record record);
}
