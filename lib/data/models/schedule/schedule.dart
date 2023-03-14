import '../common.dart';

class ScheduleResponse {
  final bool success;
  final List<ScheduleData> data;

  const ScheduleResponse({required this.success, required this.data});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    final data =
        (json['data'] as List).map((e) => ScheduleData.fromJson(e)).toList();

    return ScheduleResponse(
      success: json['success'],
      data: data,
    );
  }
}

class ScheduleData {
  final ChannelGroup channelGroup;
  final List<Schedule> schedule;

  const ScheduleData({required this.channelGroup, required this.schedule});

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    final schedule =
        (json['schedule'] as List).map((e) => Schedule.fromJson(e)).toList();
    return ScheduleData(
      channelGroup: ChannelGroup.fromJson(json['channelGroup']),
      schedule: schedule,
    );
  }
}

class ChannelGroup {
  final int mgmtId;
  final String type;
  final String name;
  final String description;
  final List<Image> channelGroupIcon;

  ChannelGroup({
    required this.mgmtId,
    required this.type,
    required this.name,
    required this.description,
    required this.channelGroupIcon,
  });

  factory ChannelGroup.fromJson(Map<String, dynamic> json) {
    List<Image> channelGroupIcons = (json['channelGroupIcon'] as List)
        .map((e) => Image.fromJson(e))
        .toList();

    return ChannelGroup(
      mgmtId: json['mgmtId'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      channelGroupIcon: channelGroupIcons,
    );
  }
}

class Schedule {
  final DateTime date;
  final List<ScheduleItem> elements;

  Schedule({required this.date, required this.elements});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date']);
    final elements = (json['elements'] as List)
        .map((e) => ScheduleItem.fromJson(e))
        .toList();
    return Schedule(date: date, elements: elements);
  }
}

class ScheduleItem {
  final int id;
  final String title;
  final String topic;
  final String game;
  final int? showId;
  final int episodeId;
  final String episodeImage;
  final DateTime timeStart;
  final DateTime timeEnd;

  ScheduleItem({
    required this.id,
    required this.title,
    required this.topic,
    required this.game,
    required this.showId,
    required this.episodeId,
    required this.episodeImage,
    required this.timeStart,
    required this.timeEnd,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    final timeStart = DateTime.parse(json['timeStart']);
    final timeEnd = DateTime.parse(json['timeEnd']);

    return ScheduleItem(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      game: json['game'],
      showId: json['showId'],
      episodeId: json['episodeId'],
      episodeImage: json['episodeImage'],
      timeStart: timeStart,
      timeEnd: timeEnd,
    );
  }
}
