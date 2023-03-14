import 'schedule_entry.dart';

class Channel {
  final int mgmtId;
  final String type;
  final String name;
  final String description;
  final String channelIconUrl;

  final Map<DateTime, List<ScheduleEntry>> schedule;

  Channel({
    required this.mgmtId,
    required this.type,
    required this.name,
    required this.description,
    required this.channelIconUrl,
    required this.schedule,
  });
}
