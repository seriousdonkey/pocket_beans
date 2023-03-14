import '../common.dart';

class NextUploadsResponse {
  final bool success;
  final List<NextUploadsData> data;

  NextUploadsResponse({required this.success, required this.data});

  factory NextUploadsResponse.fromJson(Map<String, dynamic> json) {
    final data =
        (json['data'] as List).map((e) => NextUploadsData.fromJson(e)).toList();

    return NextUploadsResponse(success: json['success'], data: data);
  }
}

class NextUploadsData {
  final DateTime date;
  final List<NextUploadsElement> elements;

  NextUploadsData({required this.date, required this.elements});

  factory NextUploadsData.fromJson(Map<String, dynamic> json) {
    final date = DateTime.parse(json['date']);
    final elements = (json['elements'] as List)
        .map((e) => NextUploadsElement.fromJson(e))
        .toList();

    return NextUploadsData(
      date: date,
      elements: elements,
    );
  }
}

class NextUploadsElement {
  final int id;
  final DateTime uploadDate;
  final String title;
  final String? topic;
  final int showId;
  final String showTitle;
  final List<Image> showThumbnail;
  final bool rbscExclusive;
  final List<Token> tokens;

  NextUploadsElement({
    required this.id,
    required this.uploadDate,
    required this.title,
    required this.topic,
    required this.showId,
    required this.showTitle,
    required this.showThumbnail,
    required this.rbscExclusive,
    required this.tokens,
  });

  factory NextUploadsElement.fromJson(Map<String, dynamic> json) {
    final uploadDate = DateTime.parse(json['uploadDate']);

    final thumbnails =
        (json['showThumbnail'] as List).map((e) => Image.fromJson(e)).toList();

    List<Token> tokens = [];
    if (json['tokens'] != null) {
      tokens = (json['tokens'] as List).map((e) => Token.fromJson(e)).toList();
    }

    return NextUploadsElement(
      id: json['id'],
      uploadDate: uploadDate,
      title: json['title'],
      topic: json['topic'],
      showId: json['showId'],
      showTitle: json['showTitle'],
      showThumbnail: thumbnails,
      rbscExclusive: json['rbscExclusive'],
      tokens: tokens,
    );
  }
}
