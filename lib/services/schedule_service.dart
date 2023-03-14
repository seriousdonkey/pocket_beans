import 'package:pocket_beans/domain/entities/channel.dart';
import 'package:pocket_beans/domain/repositories/schedule_repository.dart';
import 'package:collection/collection.dart';

import '../domain/entities/schedule_entry.dart';

class ScheduleService {
  ScheduleService({required this.scheduleRepository});

  final ScheduleRepository scheduleRepository;

  Future<List<Channel>> loadChannels() async {
    final channels = await scheduleRepository.getChannelSchedule();
    final nextUploads = await scheduleRepository.getNextUploads();

    final rocketBeansChannel =
        channels.where((channel) => channel.mgmtId == 1).first;

    final groupedNextUploads = groupBy(
        nextUploads,
        (nextUpload) => DateTime(nextUpload.uploadDate.year,
            nextUpload.uploadDate.month, nextUpload.uploadDate.day));

    groupedNextUploads.forEach((key, value) {
      if (!rocketBeansChannel.schedule.containsKey(key)) {
        rocketBeansChannel.schedule.putIfAbsent(key, () => []);
      }

      final nextUploadScheduleEntries = value.map((e) {
        return ScheduleEntry(
          id: e.id,
          title: e.title,
          topic: e.topic,
          game: e.showTitle,
          type: ScheduleType.vod,
          timeStart: e.uploadDate,
          timeEnd: null,
          youtubeToken: e.youtubeToken,
          showId: e.showId,
        );
      }).toList();
      rocketBeansChannel.schedule[key]?.addAll(nextUploadScheduleEntries);
    });

    return channels;
  }
}
