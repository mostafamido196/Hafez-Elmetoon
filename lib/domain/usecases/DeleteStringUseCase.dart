
import '../../data/repositories/AddAudioRepository.dart';


class DeleteCustomAudioUseCase {
  final CustomAudioRepository repository;

  DeleteCustomAudioUseCase(this.repository);

  Future<void> execute(int id) async {
    await repository.deleteCustomAudio(id);
  }
}