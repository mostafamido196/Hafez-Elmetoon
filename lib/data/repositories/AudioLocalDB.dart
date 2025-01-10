import 'package:hafez_elmetoon/data/models/AudioItemDB.dart';
import 'package:hafez_elmetoon/screens/Models/AudioItem.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AudioLocalDB {
  final String  _boxName = "personBox";

  Future<Box<AudioEntity>> get _box async =>
      await Hive.openBox<AudioEntity>(_boxName);

//insert
  Future<void> addPerson(AudioEntity audioItem) async {
    var box = await _box;
    await box.add(audioItem);
  }

//read
  Future<List<AudioEntity>> getAllPerson() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateDeck(int index, AudioEntity audioItem) async {
    var box = await _box;
    await box.putAt(index, audioItem);
  }

//delete
  Future<void> deletePerson(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}