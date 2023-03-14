class Episode {
  final int id;
  final String title;
  final int showId;
  final String showName;
  final String thumbnailUrl;
  final DateTime publishDate;
  final String? youtubeVideoId;

  Episode({
    required this.id,
    required this.title,
    required this.showId,
    required this.showName,
    required this.thumbnailUrl,
    required this.publishDate,
    required this.youtubeVideoId,
  });
}
