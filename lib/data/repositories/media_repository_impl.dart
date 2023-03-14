import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pocket_beans/data/models/media/last_published_episodes.dart';
import 'package:pocket_beans/data/models/media/shows.dart';
import 'package:pocket_beans/domain/entities/common.dart';
import 'package:pocket_beans/domain/entities/episode.dart';
import 'package:pocket_beans/domain/entities/episodes.dart';
import 'package:pocket_beans/domain/entities/show.dart';
import 'package:pocket_beans/domain/entities/shows.dart';
import 'package:pocket_beans/domain/repositories/media_repository.dart';

class MediaRepositoryImpl extends MediaRepository {
  @override
  Future<Episodes> getLastPublishedEpisodes(int offset, int limit) async {
    final response = await http.get(Uri.parse(
        'https://api.rocketbeans.tv/v1/media/episode/preview/newest?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final lastPublishedEpisodesResponse =
          LastPublishedEpisodesResponse.fromJson(jsonDecode(response.body));

      final pagination = Pagination(
        offset: lastPublishedEpisodesResponse.pagination.offset,
        limit: lastPublishedEpisodesResponse.pagination.limit,
        total: lastPublishedEpisodesResponse.pagination.total,
      );

      final episodes = lastPublishedEpisodesResponse.data.episodes
          .where((e) => e.thumbnail.isNotEmpty)
          .map((e) {
        var thumbnails = e.thumbnail.where(
            (element) => element.name == "medium" || element.name == 'ytsmall');

        final thumbnailUrl = thumbnails.first.url;

        String? youtubeVideoId;
        final tokens = e.tokens.where((element) => element.type == 'youtube');
        if (tokens.isNotEmpty) {
          youtubeVideoId = tokens.first.token;
        }

        return Episode(
          id: e.id,
          title: e.title,
          showId: e.showId,
          showName: e.showName,
          thumbnailUrl: thumbnailUrl,
          publishDate: e.distributionPublishingDate,
          youtubeVideoId: youtubeVideoId,
        );
      }).toList();

      return Episodes(pagination: pagination, episodes: episodes);
    }

    return Episodes(
      pagination: Pagination(
        offset: 0,
        limit: 0,
        total: 0,
      ),
      episodes: [],
    );
  }

  @override
  Future<Shows> getAllShows(int offset, int limit) async {
    final response = await http.get(Uri.parse(
        'https://api.rocketbeans.tv/v1/media/show/all?offset=$offset&limit=$limit'));

    if (response.statusCode == 200) {
      final allShowsResponse =
          AllShowsResponse.fromJson(jsonDecode(response.body));

      final pagination = Pagination(
        offset: allShowsResponse.pagination.offset,
        limit: allShowsResponse.pagination.limit,
        total: allShowsResponse.pagination.total,
      );

      final shows = allShowsResponse.data.map((e) {
        final thumbnails =
            e.thumbnail.where((element) => element.name == "medium");
        final thumbnailUrl = thumbnails.first.url;

        return Show(
          id: e.id,
          title: e.title,
          description: e.description,
          genre: e.genre,
          thumbnailUrl: thumbnailUrl,
          slideshowImageUrl: e.slideshowImageUrl,
        );
      }).toList();

      return Shows(pagination: pagination, shows: shows);
    }
    return Shows(
        pagination: Pagination(offset: 0, limit: 0, total: 0), shows: []);
  }

  @override
  Future<Show> getSingleShow(int showId) async {
    final response = await http
        .get(Uri.parse('https://api.rocketbeans.tv/v1/media/show/$showId'));

    if (response.statusCode == 200) {
      ;
      final SingleShowResponse singleShowResponse =
          SingleShowResponse.fromJson(jsonDecode(response.body));
      final show = singleShowResponse.data;

      final thumbnail =
          show.thumbnail.where((element) => element.name == 'medium');
      final thumbnailUrl = thumbnail.first.url;

      return Show(
        id: show.id,
        title: show.title,
        description: show.description,
        genre: show.genre,
        thumbnailUrl: thumbnailUrl,
        slideshowImageUrl: show.slideshowImageUrl,
      );
    }

    throw UnimplementedError();
  }
}
