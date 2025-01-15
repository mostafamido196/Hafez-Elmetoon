
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



import 'package:path/path.dart' as p;

import 'Models/AudioItem.dart';

class PlayingAudioViewModel extends ChangeNotifier {
  GetCustomAudioUseCase? _getCustomAudioUseCase;
  AddCustomAudioUseCase? _addCustomAudioUseCase;
  DeleteCustomAudioUseCase? _deleteCustomAudioUseCase;
  // bool _isInitialized = false;

  UIState _state = Loading();

  UIState get state => _state;

  final AudioPlayer audioPlayer = AudioPlayer();
  int playingIndex = -1; // initial not working
  final audioRecorder = AudioRecorder();
  bool isRecording = false;


  Future<void> init() async {
    // if (_isInitialized) return;

    final repository = await CustomAudioRepositoryImpl.create();
    _getCustomAudioUseCase = GetCustomAudioUseCase(repository);
    _addCustomAudioUseCase = AddCustomAudioUseCase(repository);
    _deleteCustomAudioUseCase = DeleteCustomAudioUseCase(repository);

    await fetchData();
    // _isInitialized = true;
    notifyListeners();
  }

  Future<void> fetchData() async {
    // if (!_isInitialized) throw StateError('ViewModel not initialized');

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
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
    final date = DateTime.now().year.toString() +
        ' / ' +
        DateTime.now().month.toString() +
        ' / ' +
        DateTime.now().day.toString();
    await _addCustomAudioUseCase
        ?.execute(AudioItem(title: file.name, path: file.path!, date: date));
    await fetchData();
  }

  Future<void> onAudioPlay(int index, String path, int repeat) async {
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
    // Check if file exists
    if (!await File(path).exists()) {
      print('Error: File does not exist at path: $path');
      return;
    }

    playingIndex = index;
    notifyListeners();
    for (int i = 0; i < repeat; i++) {
      try {
        await audioPlayer.stop(); // Stop any currently playing audio
        await audioPlayer.play(DeviceFileSource(path)); // Start new audio
        await audioPlayer.onPlayerComplete.first; // Wait for audio to finish
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  Future<void> startRecording() async {
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
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
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
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

  void stopAudio() async {
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
    await audioPlayer.stop();
    playingIndex = -1;
    notifyListeners();
  }

  Future<void> onDeleteItem(int index) async {
    // if (!_isInitialized) throw StateError('ViewModel not initialized');
    if (index == this.playingIndex) await audioPlayer.stop();
    await _deleteCustomAudioUseCase?.execute(index);
    await fetchData();
  }

}