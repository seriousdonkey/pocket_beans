import 'package:pocket_beans/domain/entities/episodes.dart';

import '../entities/show.dart';
import '../entities/shows.dart';

abstract class MediaRepository {
  Future<Episodes> getLastPublishedEpisodes(int offset, int limit);

  Future<Shows> getAllShows(int offset, int limit);

  Future<Show> getSingleShow(int showId);
}
