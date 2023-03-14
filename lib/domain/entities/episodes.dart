import 'package:pocket_beans/domain/entities/common.dart';

import 'episode.dart';

class Episodes {
  final Pagination pagination;
  final List<Episode> episodes;

  Episodes({required this.pagination, required this.episodes});
}
