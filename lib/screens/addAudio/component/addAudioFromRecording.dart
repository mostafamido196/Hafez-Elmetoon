import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddAudioFromRecording extends StatelessWidget {
  final bool isRecording;
  final Future<void> Function() onRecord;
  final Future<void> Function() onStop;

  const AddAudioFromRecording(this.isRecording, this.onRecord, this.onStop,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () async {
        try {
          if (isRecording)
            await onStop();
          else {
            await onRecord();
          }
        } catch (e) {
          print("Error starting recording: $e");
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isRecording
                ? 'assets/Images/stop_recording.svg'
                : 'assets/Images/start_recording.svg',
            height: 80, // Set appropriate size
            width: 80,
          ),
          SizedBox(height: 8), // Spacing between image and text
          Text(
            'تسجيل مقطع',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ));
  }
}
