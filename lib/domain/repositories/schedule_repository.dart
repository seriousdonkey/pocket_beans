import 'package:pocket_beans/domain/entities/next_upload.dart';

import '../entities/channel.dart';

abstract class ScheduleRepository {
  Future<List<Channel>> getChannelSchedule();

  Future<List<NextUpload>> getNextUploads();
}
