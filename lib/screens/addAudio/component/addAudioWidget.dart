import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'addAudioFromFiles.dart';
import 'addAudioFromRecording.dart';

class AddAudioWidget extends StatelessWidget {
  final Function(PlatformFile file) onAdd;
  final bool isRecording;
  final Future<void> Function() onRecord;
  final Future<void> Function() onStop;
  const AddAudioWidget(this.onAdd,this.isRecording, this.onRecord,this.onStop, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddAudioFromRecording(isRecording,onRecord,onStop),
        AddAudioFromFiles(onAdd),
      ],
    );  }
}
