import 'package:pocket_beans/domain/repositories/schedule_repository.dart';

import '../entities/next_upload.dart';

class GetNextUploads {
  final ScheduleRepository scheduleRepository;

  GetNextUploads(this.scheduleRepository);

  Future<List<NextUpload>> execute() {
    return scheduleRepository.getNextUploads();
  }
}
