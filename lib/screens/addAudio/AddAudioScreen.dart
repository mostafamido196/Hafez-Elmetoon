import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/addAudioWidget.dart';
import 'package:hafez_elmetoon/screens/addAudio/component/audioList.dart';
import 'package:hafez_elmetoon/screens/addAudio/player_bloc/player_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../core/UIState.dart';
import '../Models/AudioItem.dart';
import '../PlayingAudioViewModel.dart';
import 'component/AudioListShimmer.dart';
import 'AudioListViewModel.dart';
import 'component/home_bottom_player.dart';

class AddAudioScreen extends StatelessWidget {
  final String title;

  const AddAudioScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              final viewModel = AudioListViewModel();
              viewModel.init();
              return viewModel;
            },
          ),
          ChangeNotifierProvider(create: (_) => PlayingAudioViewModel()),
          BlocProvider(
            create: (_) => PlayerBloc(player: AudioPlayer()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('حافظ المتون'),
          ),
          body: Consumer<AudioListViewModel>(
              builder: (context, audioListViewModel, child) {
            final state = audioListViewModel.state;
            print('setting screen state: $state');
            return Column(children: [
              AddAudioWidget(
                  audioListViewModel.addAudioFromFiles,
                  audioListViewModel.isRecording,
                  audioListViewModel.startRecording,
                  audioListViewModel.stopRecording),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              AudioListState(state, audioListViewModel)
            ]);
          }),
        ));
  }

  Widget AudioListState(UIState state, AudioListViewModel audioManager) {
    if (state is Loading)
      return Expanded(child: AudioListShimmer());
    else if (state is Success<List<AudioItem>>)
      return Expanded(
          child: Stack(
        children: [
          AudioList(audioList: state.data, onDelete: audioManager.onDeleteItem),
          Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BottomPlayer(),
              )
          )
        ],
      ));
    else if (state is Error)
      return Center(child: Text("Error: ${state.errorMessage}"));
    else
      return Center(child: Text("Unknown State"));
  }
}
