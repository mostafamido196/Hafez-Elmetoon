import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/Widgets/addAudio/addAudioWidget.dart';
import '../../Widgets/addAudio/audioList.dart';
import 'AudioItem.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AddAudioScreen extends StatefulWidget {
  final String title;

  AddAudioScreen({super.key, required this.title});

  @override
  State<AddAudioScreen> createState() => _AddAudioScreenState();
}

class _AddAudioScreenState extends State<AddAudioScreen> {
  final List<AudioItem> audioList = [
    AudioItem(
        title: 'كريمٌ منعمٌ برٌ لطيف',
        date: '2024-11-20',
        path:
            '/data/user/0/com.samy.hafez_elmetoon/cache/file_picker/نغمة كريم منعم بر لطيف.mp3'),
  ];
  final AudioPlayer _audioPlayer = AudioPlayer();
  int playingIndex = -1; // initial not working

///recording






  ///


  void addAudio(PlatformFile file) {
    print('mos samy file: ${file.name}');
    final date = DateTime.now().year.toString() +
        ' / ' +
        DateTime.now().month.toString() +
        ' / ' +
        DateTime.now().day.toString();
    setState(() {
      audioList.add(AudioItem(
        title: file.name,
        path: file.path!,
        date: date,
      ));
    });
  }

  Future<void> onAudioPlay(int index, String path, int repeat) async {
    print('play audio path; $path');
    setState(() {
      playingIndex = index;
    });
    for (int i = 0; i < repeat; i++) {
      try {
        await _audioPlayer.stop(); // Stop any currently playing audio
        await _audioPlayer.play(DeviceFileSource(path)); // Start new audio
        await _audioPlayer.onPlayerComplete.first; // Wait for audio to finish
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  Future<void> onDeleteItem(int index) async {
    if (index == this.playingIndex)
      await _audioPlayer.stop(); // Stop any currently playing audio

    setState(() {
      audioList.removeAt(index);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the player when the widget is removed
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('حافظ المتون'),
        ),
        body: Column(
          children: [
            AddAudioWidget(addAudio),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            AudioList(
                audioList: audioList,
                onDelete: onDeleteItem,
                onPlayAudio: onAudioPlay),
          ],
        ));
  }
}
