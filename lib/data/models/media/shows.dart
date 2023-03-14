import '../common.dart';

class AllShowsResponse {
  final bool success;
  final Pagination pagination;
  final List<ShowData> data;

  AllShowsResponse({
    required this.success,
    required this.pagination,
    required this.data,
  });

  factory AllShowsResponse.fromJson(Map<String, dynamic> json) {
    final pagination = Pagination.fromJson(json['pagination']);
    final data =
        (json['data'] as List).map((e) => ShowData.fromJson(e)).toList();

    return AllShowsResponse(
      success: json['success'],
      pagination: pagination,
      data: data,
    );
  }
}

class SingleShowResponse {
  final bool success;
  final ShowData data;

  SingleShowResponse({required this.success, required this.data});

  factory SingleShowResponse.fromJson(Map<String, dynamic> json) {
    return SingleShowResponse(
      success: json['success'],
      data: ShowData.fromJson(json['data']),
    );
  }
}

class ShowData {
  final int id;
  final String title;
  final String? description;
  final String? genre;
  final List<Image> thumbnail;
  final String slideshowImageUrl;

  ShowData({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
    required this.thumbnail,
    required this.slideshowImageUrl,
  });

  factory ShowData.fromJson(Map<String, dynamic> json) {
    final thumbnails =
        (json['thumbnail'] as List).map((e) => Image.fromJson(e)).toList();

    final slideshowImage = (json['slideshowImages'] as List)
        .map((arr) => arr as List)
        .map((arr2) => Image.fromJson(arr2[0]))
        .first;

    return ShowData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      genre: json['genre'],
      thumbnail: thumbnails,
      slideshowImageUrl: slideshowImage.url,
    );
  }
}
