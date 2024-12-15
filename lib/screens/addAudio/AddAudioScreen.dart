import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../managers/AudioManager.dart';
import '../../Widgets/addAudio/addAudioWidget.dart';
import '../../Widgets/addAudio/audioList.dart';

class AddAudioScreen extends StatelessWidget {
  final String title;

  const AddAudioScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AudioManager>(
      create: (context) => AudioManager(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('حافظ المتون'),
        ),
        body: Consumer<AudioManager>(
          builder: (context, audioManager, child) => Column(
            children: [

              AddAudioWidget(
                  audioManager.addAudioFromFiles,
                  audioManager.isRecording,
                  audioManager.startRecording,
                  audioManager.stopRecording
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              AudioList(
                  audioList: audioManager.audioList,
                  onDelete: audioManager.onDeleteItem,
                  onPlayAudio: audioManager.onAudioPlay
              ),
            ],
          ),
        ),
      ),
    );
  }
}