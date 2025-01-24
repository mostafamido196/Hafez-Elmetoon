class AudioFile {
  final int? id;
  final String? name;
  final String? path;
  final String? size;
  final String? length;
  AudioFile({this.id, this.name, this.path, this.size, this.length,});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'size': size,
      'length': length,

    };
  }
  factory AudioFile.fromMap(Map<String, dynamic> map) {
    return AudioFile(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      size: map['size'],
      length: map['length'],
    );
  }
}