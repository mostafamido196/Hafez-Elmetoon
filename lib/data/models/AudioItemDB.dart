
class AudioEntity {
  final int? id;
  final String title;
  final String path;
  final String date;

  AudioEntity.AudioEntity({
    this.id,
    required this.title,
    required this.path,
    required this.date,
  });
}


class StringItem extends AudioEntity {
  StringItem({
    int? id,
    required String title,
    required String path,
    required String date,
  }) : super.AudioEntity(id: id, title: title, path: path, date: date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'date': date,
    };
  }

  factory StringItem.fromMap(Map<String, dynamic> map) {
    return StringItem(
      id: map['id'],
      title: map['title'],
      path: map['path'],
      date: map['date'],
    );
  }

  factory StringItem.fromEntity(AudioEntity entity) {
    return StringItem(
      id: entity.id,
      title: entity.title,
      path: entity.path,
      date: entity.date,
    );
  }
}
