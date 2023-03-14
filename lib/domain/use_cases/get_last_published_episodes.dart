import 'package:pocket_beans/domain/entities/episodes.dart';
import 'package:pocket_beans/domain/repositories/media_repository.dart';

class GetLastPublishedEpisodes {
  final MediaRepository mediaRepository;

  GetLastPublishedEpisodes(this.mediaRepository);

  Future<Episodes> execute(int offset, int limit) {
    return mediaRepository.getLastPublishedEpisodes(offset, limit);
  }
}
