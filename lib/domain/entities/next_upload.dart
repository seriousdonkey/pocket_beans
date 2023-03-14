class NextUpload {
  final int id;
  final DateTime uploadDate;
  final String title;
  final String? topic;
  final int showId;
  final String showTitle;
  final String thumbnailUrl;
  final String? youtubeToken;

  NextUpload({
    required this.id,
    required this.uploadDate,
    required this.title,
    required this.topic,
    required this.showId,
    required this.showTitle,
    required this.thumbnailUrl,
    required this.youtubeToken,
  });
}
