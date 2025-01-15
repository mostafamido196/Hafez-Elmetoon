
import '../../data/local/models/AudioModel.dart';
import '../../data/repositories/AddAudioRepository.dart';

class GetCustomAudioUseCase {
  final CustomAudioRepository repository;

  GetCustomAudioUseCase(this.repository);

  Future<List<AudioEntity>> execute() async {
    print('mos samy excute usecase get audio use case');
    return await repository.getAllCustomAudios();
  }
}