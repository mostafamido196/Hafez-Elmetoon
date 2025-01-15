import 'package:floor/floor.dart';

@Entity(tableName: 'RECORDS')
class Record {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String path;
  final String date;

  Record({this.id, required this.title, required this.path, required this.date});
}
