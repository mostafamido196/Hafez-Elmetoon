import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/Rout.dart';
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
        title: 'البسملة.mp3',
        date: '2024-11-20',
        path:
            '/data/user/0/com.samy.hafez_elmetoon/cache/file_picker/البسملة.mp3'),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();


  Future<void> _playAudio(String path, int repeat) async {
    print('play audio path; $path');
    for (int i = 0; i < repeat; i++) {
      try {
        await _audioPlayer.stop(); // Stop any currently playing audio
        await _audioPlayer.play(DeviceFileSource(path)); // Start new audio
        await _audioPlayer.onPlayerComplete.first; // Wait for audio to finish
    }  catch (e) {
        print("Error playing audio: $e");
      }
    }
  }



  int selectedNumber = 1;

  Future<void> showNumberPicker(String path) async {
    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a number'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                10,
                (index) => ListTile(
                  title: Text((index + 1).toString()),
                  onTap: () {
                    _playAudio(path, index + 1);
                    Navigator.of(context).pop(index + 1);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    // if (result != null) {
    //   setState(() {
    //     selectedNumber = result;
    //   });
    // }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the player when the widget is removed
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
            Row(
              children: [
                Expanded(
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
                ),
                Expanded(
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
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            _AudioListWidget(),
          ],
        ));
  }

  Widget _AudioListWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: audioList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
              onTap: () => showNumberPicker(audioList[index].path),
              child: _ItemAudioList(context, index)),
        );
      },
    ));
  }

  Widget _ItemAudioList(BuildContext context, int index) {
    final item = audioList[index];
    return Card(
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
        title: GestureDetector(
            onTap: () => showNumberPicker(audioList[index].path),
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        subtitle: GestureDetector(
            onTap: () => showNumberPicker(audioList[index].path),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Date: ${item.date}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Path: ${item.path}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
        trailing: GestureDetector(
            onTap: () => showNumberPicker(audioList[index].path),
            child: IconButton(
              icon: GestureDetector(
                  onTap: () => showNumberPicker(audioList[index].path),
                  child: const Icon(Icons.play_arrow, color: Colors.teal)),
              onPressed: () {
                // Move the play logic to here if you want the icon button to trigger audio
                print('play audio from trailing IconButton');
                showNumberPicker(audioList[index].path);
              },
            )),
        onLongPress: () {
          _showDeleteDialog(context, index);
        },
      ),
    );
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
                Navigator.of(context).pop();
              },
              child: const Text('الغاء'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  audioList.removeAt(index);
                });
                Navigator.of(context).pop();
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

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      final file = result.files.single;
      final date = DateTime.now().year.toString() +
          ' / ' +
          DateTime.now().month.toString() +
          ' / ' +
          DateTime.now().day.toString();
      print('_pickAudioFile name: ${file.name}');
      print('_pickAudioFile path: ${file.path}');
      print('_pickAudioFile data: $date');
      setState(() {
        audioList.add(AudioItem(
          title: file.name,
          path: file.path!,
          date: date,
        ));
      });
    }
  }
}
