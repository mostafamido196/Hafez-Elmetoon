import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hafez_elmetoon/screens/PlayingAudioViewModel.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/repeatePopup.dart';
import '../../Models/AudioItem.dart';
import 'ItemAudioList.dart';
import 'package:provider/provider.dart' as provider;

class AudioList extends StatelessWidget {
  final List<AudioItem> audioList;
  final void Function(int) onDelete;

  const AudioList({super.key, required this.audioList, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final viewModel = provider.Provider.of<PlayingAudioViewModel>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () => showNumberPickerDialog(
                context,
                index,
                audioList[index].path,
                viewModel.onAudioPlay,
              ),
              child: _ItemAudioList(
                context,
                index,
                viewModel.onAudioPlay,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _ItemAudioList(BuildContext context, int index,
      Future<void> Function(int, String, int) onPlayAudio) {
    return ItemAudioList(
        audioItem: audioList[index],
        index: index,
        onDelete: onDelete,
        onPlayAudio: onPlayAudio);
  }
}
