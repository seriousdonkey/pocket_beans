import 'package:pocket_beans/data/models/common.dart';

class LastPublishedEpisodesResponse {
  final bool success;
  final Pagination pagination;
  final LastPublishEpisodesData data;

  LastPublishedEpisodesResponse({
    required this.success,
    required this.pagination,
    required this.data,
  });

  factory LastPublishedEpisodesResponse.fromJson(Map<String, dynamic> json) {
    final LastPublishEpisodesData data =
        LastPublishEpisodesData.fromJson(json['data']);
    final pagination = Pagination.fromJson(json['pagination']);

    return LastPublishedEpisodesResponse(
      success: json['success'],
      pagination: pagination,
      data: data,
    );
  }
}

class LastPublishEpisodesData {
  final List<LastPublishEpisode> episodes;

  LastPublishEpisodesData({
    required this.episodes,
  });

  factory LastPublishEpisodesData.fromJson(Map<String, dynamic> json) {
    final data = (json['episodes'] as List)
        .map((e) => LastPublishEpisode.fromJson(e))
        .toList();

    return LastPublishEpisodesData(episodes: data);
  }
}

class LastPublishEpisode {
  final int id;
  final String title;
  final int showId;
  final String showName;
  final List<Image> thumbnail;
  final DateTime distributionPublishingDate;
  final List<Token> tokens;

  LastPublishEpisode({
    required this.id,
    required this.title,
    required this.showId,
    required this.showName,
    required this.thumbnail,
    required this.distributionPublishingDate,
    required this.tokens,
  });

  factory LastPublishEpisode.fromJson(Map<String, dynamic> json) {
    final publishDate = DateTime.parse(json['distributionPublishingDate']);
    final List<Image> thumbnails =
        (json['thumbnail'] as List).map((e) => Image.fromJson(e)).toList();

    final List<Token> tokens =
        (json['tokens'] as List).map((e) => Token.fromJson(e)).toList();

    return LastPublishEpisode(
      id: json['id'],
      title: json['title'],
      showId: json['showId'],
      showName: json['showName'],
      thumbnail: thumbnails,
      distributionPublishingDate: publishDate,
      tokens: tokens,
    );
  }
}
