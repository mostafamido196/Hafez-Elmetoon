import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../screens/addAudio/AudioItem.dart';

import 'package:path/path.dart' as p;

class AudioManager extends ChangeNotifier {
  final List<AudioItem> audioList = [
    AudioItem(
        title: 'كريمٌ منعمٌ برٌ لطيف',
        date: '2024-11-20',
        path:
            '/data/user/0/com.samy.hafez_elmetoon/cache/file_picker/نغمة كريم منعم بر لطيف.mp3'),
  ];
  final AudioPlayer audioPlayer = AudioPlayer();
  int playingIndex = -1; // initial not working
  final audioRecorder = AudioRecorder();
  bool isRecording = false;

  void addAudioFromFiles(PlatformFile file) {
    print('mos samy file: ${file.name}');
    final date = DateTime.now().year.toString() +
        ' / ' +
        DateTime.now().month.toString() +
        ' / ' +
        DateTime.now().day.toString();
    audioList.add(AudioItem(
      title: file.name,
      path: file.path!,
      date: date,
    ));
    notifyListeners();
  }


  Future<void> onAudioPlay(int index, String path, int repeat) async {
    print('play audio path; $path');
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
      isRecording = false;
      audioList.add(
          AudioItem(title: 'record title', date: 'Date.now', path: filePath));
    }
    notifyListeners();
  }


  void stopAudio() async {
    await audioPlayer.stop();
    playingIndex = -1;
    notifyListeners();
  }
  Future<void> onDeleteItem(int index) async {
    if (index == this.playingIndex)
      await audioPlayer.stop(); // Stop any currently playing audio
    audioList.removeAt(index);
    notifyListeners();
  }
}
