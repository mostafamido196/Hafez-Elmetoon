import 'package:flutter/cupertino.dart';

class AddAudioFromRecording extends StatelessWidget {
  const AddAudioFromRecording({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Images/record2.png',
            // Replace with your image path
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
    );
  }
}
