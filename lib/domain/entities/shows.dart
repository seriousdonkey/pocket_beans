import 'package:pocket_beans/domain/entities/common.dart';

import 'show.dart';

class Shows {
  final Pagination pagination;
  final List<Show> shows;

  Shows({
    required this.pagination,
    required this.shows,
  });
}
