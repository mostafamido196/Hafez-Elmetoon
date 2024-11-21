import 'package:flutter/material.dart';

import 'AudioItem.dart';

class AddAudioScreen extends StatefulWidget {
  final String title;

  AddAudioScreen({super.key, required this.title});

  @override
  State<AddAudioScreen> createState() => _AddAudioScreenState();
}

class _AddAudioScreenState extends State<AddAudioScreen> {
  final List<AudioItem> audioItems = [
    AudioItem(
        title: 'Recording 1', date: '2024-11-20', path: '/storage/audio1.mp3'),
    AudioItem(
        title: 'Meeting Notes',
        date: '2024-11-19',
        path: '/storage/audio2.mp3'),
    AudioItem(
        title: 'Lecture', date: '2024-11-18', path: '/storage/audio3.mp3'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('حافظ المتون'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/record2.png',
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
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/upload.webp',
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
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: audioItems.length,
                itemBuilder: (context, index) {
                  final item = audioItems[index];
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal.withOpacity(0.2),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.teal,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Date: ${item.date}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Path: ${item.path}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[500]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.teal),
                          onPressed: () {
                            // Add logic to play the audio file
                          },
                        ),
                        onLongPress: () {
                          _showDeleteDialog(context, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حذف المقطع الصوتي'),
          content: const Text('هل انت متأكد من انك تريد حذف المقطع الصوتي؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text('الغاء'),
            ),
            TextButton(
              onPressed: () {

                setState(() {
                  audioItems.removeAt(index);
                });
                Navigator.of(context).pop(); // Dismiss dialog
                // Trigger UI update
                (context as Element).reassemble();
              },
              child: const Text(
                'حذف',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
// Navigator.pop(context);
