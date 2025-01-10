
import 'dart:ffi';

import '../../data/models/AudioItemDB.dart';
import '../../data/repositories/AddAudioRepository.dart';
import '../../screens/Models/AudioItem.dart';

class AddCustomAudioUseCase {
  final CustomAudioRepository repository;

  AddCustomAudioUseCase(this.repository);

  Future<void> execute(AudioItem item) async {
    await repository.addCustomAudio(item);
  }
}