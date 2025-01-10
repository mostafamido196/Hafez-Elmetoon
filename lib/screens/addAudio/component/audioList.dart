import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/repeatePopup.dart';

import '../../Models/AudioItem.dart';
import 'ItemAudioList.dart';


class AudioList extends StatelessWidget {
  final List<AudioItem> audioList;
  final void Function(int) onDelete;
  final Future<void> Function(int, String, int) onPlayAudio;

  const AudioList(
      {super.key,
      required this.audioList,
      required this.onPlayAudio,
      required this.onDelete}) ;

  @override
  Widget build(BuildContext context) {
    print('audioList file audiolist lingth: ${audioList.length}');
    return Expanded(
        child: ListView.builder(
      itemCount: audioList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
              onTap: () => showNumberPickerDialog(
                  context, index, audioList[index].path, onPlayAudio),
              child: _ItemAudioList(context, index)),
        );
      },
    ));
  }

  Widget _ItemAudioList(BuildContext context, int index) {
    return ItemAudioList(
        audioItem: audioList[index],
        index: index,
        onDelete: onDelete,
        onPlayAudio: onPlayAudio);
  }
}
