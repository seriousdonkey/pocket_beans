import 'package:pocket_beans/domain/repositories/media_repository.dart';

import '../entities/show.dart';

class GetShow {
  final MediaRepository mediaRepository;

  GetShow(this.mediaRepository);

  Future<Show> execute(int showId) async {
    return mediaRepository.getSingleShow(showId);
  }
}
