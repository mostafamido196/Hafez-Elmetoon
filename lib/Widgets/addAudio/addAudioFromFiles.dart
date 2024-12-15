import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddAudioFromFiles extends StatelessWidget {
  final Function(PlatformFile file) onAdd;
  const AddAudioFromFiles(this.onAdd,{super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: _pickAudioFile,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Images/upload.webp',
                // Replace with your image path
                height: 80,
                width: 80,
              ),
              SizedBox(height: 8),
              Text(
                'من الهاتف',
                style: TextStyle(fontSize: 16),
              ),
            ],
          )),
    );
  }
  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      final file = result.files.single;
       onAdd(file);
    }
  }

}
