import 'package:pocket_beans/domain/repositories/media_repository.dart';

import '../entities/shows.dart';

class GetAllShows {
  final MediaRepository mediaRepository;

  GetAllShows(this.mediaRepository);

  Future<Shows> execute(int offset, int limit) {
    return mediaRepository.getAllShows(offset, limit);
  }
}
