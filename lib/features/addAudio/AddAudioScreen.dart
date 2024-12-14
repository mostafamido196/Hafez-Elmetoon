import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:hafez_elmetoon/Widgets/addAudio/addAudioWidget.dart';
import '../../Widgets/addAudio/audioList.dart';
import 'AudioItem.dart';

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
  final _audioRecorder = AudioRecorder();
  bool isRecording = false, isPlaying = false;


  Future<void> startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      final Directory appDocumentsDir =
      await getApplicationDocumentsDirectory();
      final String filePath =
      p.join(appDocumentsDir.path, "recording.wav");
      await _audioRecorder.start(
        const RecordConfig(),
        path: filePath,
      );
      setState(() {
        isRecording = true;
      });
    }
  }
  void addAudioFromFiles(PlatformFile file) {
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

  Future<void> stopRecording() async {
    String? filePath = await _audioRecorder.stop();
    if (filePath != null) {
      setState(() {
        isRecording = false;
        audioList.add(AudioItem(title: 'record title', date: 'Date.now', path: filePath));
      });
    }
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
    _audioRecorder.dispose();
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
            AddAudioWidget(addAudioFromFiles, isRecording, startRecording,
                stopRecording),
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
