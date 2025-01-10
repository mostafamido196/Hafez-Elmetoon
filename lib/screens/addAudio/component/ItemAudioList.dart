import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/repeatePopup.dart';


import '../../Models/AudioItem.dart';
import 'deletePopup.dart';

class ItemAudioList extends StatelessWidget {
  final AudioItem audioItem;

  final int index;

  final void Function(int) onDelete;
  final Future<void> Function(int, String, int) onPlayAudio;

  const ItemAudioList(
      {super.key,
      required this.audioItem,
      required this.index,
      required this.onDelete,
      required this.onPlayAudio});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => showNumberPickerDialog(
                context, index, audioItem.path, onPlayAudio),
            child: Text(
              audioItem.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        subtitle: GestureDetector(
            onTap: () => showNumberPickerDialog(
                context, index, audioItem.path, onPlayAudio),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Date: ${audioItem.date}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  'Path: ${audioItem.path}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
        trailing: GestureDetector(
            onTap: () => showNumberPickerDialog(
                context, index, audioItem.path, onPlayAudio),
            child: IconButton(
              icon: GestureDetector(
                  onTap: () => showNumberPickerDialog(
                      context, index, audioItem.path, onPlayAudio),
                  child: const Icon(Icons.play_arrow, color: Colors.teal)),
              onPressed: () {
                print('play audio from trailing IconButton');
                showNumberPickerDialog(
                    context, index, audioItem.path, onPlayAudio);
              },
            )),
        onLongPress: () {
          showDeletePopup(
              context: context, index: audioItem.id!, onDeleteItem: onDelete);
        },
      ),
    );
  }
}
