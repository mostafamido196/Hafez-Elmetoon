import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'addAudioFromFiles.dart';
import 'addAudioFromRecording.dart';

class AddAudioWidget extends StatelessWidget {
  final Function(PlatformFile file) onAdd;
  const AddAudioWidget(this.onAdd, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddAudioFromRecording(),
        AddAudioFromFiles(onAdd),
      ],
    );  }
}
