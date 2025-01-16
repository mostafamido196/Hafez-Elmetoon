
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../core/UIState.dart';
import '../../data/repositories/AddAudioRepository.dart';
import '../../domain/usecases/AddStringUseCase.dart';
import '../../domain/usecases/DeleteStringUseCase.dart';
import '../../domain/usecases/GetStringsUseCase.dart';
import '../Models/AudioItem.dart';


import 'package:path/path.dart' as p;

class AudioListViewModel extends ChangeNotifier {
   GetCustomAudioUseCase? _getCustomAudioUseCase;
   AddCustomAudioUseCase? _addCustomAudioUseCase;
   DeleteCustomAudioUseCase? _deleteCustomAudioUseCase;

  UIState _state = Loading();

  UIState get state => _state;

  final audioRecorder = AudioRecorder();
  bool isRecording = false;


  Future<void> init() async {
    final repository = await CustomAudioRepositoryImpl.create();
    _getCustomAudioUseCase = GetCustomAudioUseCase(repository);
    _addCustomAudioUseCase = AddCustomAudioUseCase(repository);
    _deleteCustomAudioUseCase = DeleteCustomAudioUseCase(repository);

    await fetchData();
    notifyListeners();
  }

   Future<void> fetchData() async {

     try {
       _state = Loading();
       notifyListeners();

       // Use non-null assertion since we've checked initialization
       final audioListEntity = await _getCustomAudioUseCase!.execute();
       final audioList = audioListEntity.map((it) => AudioItem(
           id: it.id,
           title: it.title,
           date: it.date,
           path: it.path
       )).toList();

       _state = Success(audioList);
     } catch (e) {
       print('Error: ${e.toString()}');
       _state = Error(e.toString());
     }

     notifyListeners();
   }

  Future<void> addAudioFromFiles(PlatformFile file) async {
    final date = DateTime.now().year.toString() +
        ' / ' +
        DateTime.now().month.toString() +
        ' / ' +
        DateTime.now().day.toString();
    await _addCustomAudioUseCase
        ?.execute(AudioItem(title: file.name, path: file.path!, date: date));
    await fetchData();
  }


  Future<void> startRecording() async {
    if (await audioRecorder.hasPermission()) {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      final String filePath = p.join(appDocumentsDir.path, "recording.wav");
      await audioRecorder.start(
        const RecordConfig(),
        path: filePath,
      );
      isRecording = true;
      notifyListeners();
    }
  }

  Future<void> stopRecording() async {
    String? filePath = await audioRecorder.stop();
    if (filePath != null) {
      await _addCustomAudioUseCase?.execute(AudioItem(
          title: filePath.split('/').last,
          path: filePath,
          date: DateTime.now().toString()));
      isRecording = false;
      fetchData();
    }
    notifyListeners();
  }



  Future<void> onDeleteItem(int index) async {
    await _deleteCustomAudioUseCase?.execute(index);
    await fetchData();
  }
}
