class ScheduleEntry {
  final int id;
  final String title;
  final String? topic;
  final String? game;
  final ScheduleType type;
  final DateTime timeStart;
  final DateTime? timeEnd;
  final String? youtubeToken;
  final int? showId;

  ScheduleEntry({
    required this.id,
    required this.title,
    required this.topic,
    required this.game,
    required this.type,
    required this.timeStart,
    required this.timeEnd,
    required this.youtubeToken,
    required this.showId,
  });
}

enum ScheduleType {
  gameplay,
  justChatting,
  vod,
}
