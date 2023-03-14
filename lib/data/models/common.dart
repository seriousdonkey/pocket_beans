class Image {
  final int width;
  final int height;
  final String name;
  final String url;

  Image(
      {required this.width,
      required this.height,
      required this.name,
      required this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      width: json['width'],
      height: json['height'],
      name: json['name'],
      url: json['url'],
    );
  }
}

class Pagination {
  final int offset;
  final int limit;
  final int total;

  Pagination({
    required this.offset,
    required this.limit,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
    );
  }
}

class Token {
  final int id;
  final int mediaEpisodeId;
  final String token;
  final String type;
  final int length;

  Token({
    required this.id,
    required this.mediaEpisodeId,
    required this.token,
    required this.type,
    required this.length,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json['id'],
      mediaEpisodeId: json['mediaEpisodeId'],
      token: json['token'],
      type: json['type'],
      length: json['length'],
    );
  }
}
