
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayingAudioViewModel extends ChangeNotifier {


  final AudioPlayer audioPlayer = AudioPlayer();
  int playingIndex = -1; // initial not working

  Future<void> onAudioPlay(int index, String path, int repeat) async {
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
  void stopAudio() async {
    await audioPlayer.stop();
    playingIndex = -1;
    notifyListeners();
  }
}