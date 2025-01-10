import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/material.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/addAudioWidget.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/audioList.dart';
import 'package:provider/provider.dart';

import '../../core/UIState.dart';
import '../Models/AudioItem.dart';
import 'component/AudioListShimmer.dart';
import 'AudioViewModel.dart';

class AddAudioScreen extends StatelessWidget {
  final String title;

  const AddAudioScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddAudioViewModel>(
        create: (context) => AddAudioViewModel()..fetchData(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('حافظ المتون'),
          ),
          body: Consumer<AddAudioViewModel>(builder: (context, viewModel, child) {
            final state = viewModel.state;
            print('mos samy state: $state');
            return Column(children: [
              AddAudioWidget(
                  viewModel.addAudioFromFiles,
                  viewModel.isRecording,
                  viewModel.startRecording,
                  viewModel.stopRecording),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              AudioListState(state,viewModel)
            ]);
          }),
        ));
  }

  Widget AudioListState(UIState state, AddAudioViewModel audioManager) {
    if (state is Loading)
     return Expanded(child: AudioListShimmer());
    else if (state is Success<List<AudioItem>>)
      return AudioList(
          audioList: state.data,
          onDelete: audioManager.onDeleteItem,
          onPlayAudio: audioManager.onAudioPlay);
    else if (state is Error)
      return Center(child: Text("Error: ${state.errorMessage}"));
    else
      return Center(child: Text("Unknown State"));
  }
}
