import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_beans/data/models/schedule/next_uploads.dart';
import 'package:pocket_beans/data/models/schedule/schedule.dart';
import 'package:pocket_beans/domain/entities/channel.dart';
import 'package:pocket_beans/domain/entities/next_upload.dart';
import 'package:pocket_beans/domain/entities/schedule_entry.dart';
import 'package:pocket_beans/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<List<Channel>> getChannelSchedule() async {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

    final startDay = firstDayOfWeek.toUtc().millisecondsSinceEpoch / 1000;
    final endDay = lastDayOfWeek.toUtc().millisecondsSinceEpoch / 1000;

    final apiUrl =
        'https://api.rocketbeans.tv/v1/schedule?startDay=$startDay&endDay=$endDay';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final scheduleResponse =
          ScheduleResponse.fromJson(jsonDecode(response.body));

      final List<Channel> channels = [];
      for (ScheduleData data in scheduleResponse.data) {
        final iconUrl = data.channelGroup.channelGroupIcon
            .where((element) => element.name == "medium")
            .first
            .url;

        final groupedScheduleItems = groupBy(
                data.schedule, (schedule) => schedule.date)
            .map((key, value) => MapEntry(key.toLocal(), value.first.elements));

        final items = groupedScheduleItems.map((key, value) {
          final items = value.map(
            (e) {
              ScheduleType type;
              if (e.game == 'Just Chatting') {
                type = ScheduleType.justChatting;
              } else {
                type = ScheduleType.gameplay;
              }

              return ScheduleEntry(
                id: e.id,
                title: e.title,
                topic: e.topic,
                game: e.game,
                type: type,
                timeStart: e.timeStart.toLocal(),
                timeEnd: e.timeEnd.toLocal(),
                youtubeToken: null,
                showId: e.showId,
              );
            },
          ).toList();

          return MapEntry(key, items);
        });

        final channel = Channel(
          mgmtId: data.channelGroup.mgmtId,
          type: data.channelGroup.type,
          name: data.channelGroup.name,
          description: data.channelGroup.description,
          channelIconUrl: iconUrl,
          schedule: items,
        );
        channels.add(channel);
      }

      return channels;
    }

    return [];
  }

  @override
  Future<List<NextUpload>> getNextUploads() async {
    final response = await http.get(Uri.parse(
        'https://api.rocketbeans.tv/v1/schedule/publish?from=1672095600'));

    if (response.statusCode == 200) {
      final nextUploadsResponse =
          NextUploadsResponse.fromJson(jsonDecode(response.body));

      final List<NextUpload> nextUploads = [];
      for (final nextUploadData in nextUploadsResponse.data) {
        for (var e in nextUploadData.elements) {
          if (e.rbscExclusive) {
            continue;
          }

          final thumbnail = e.showThumbnail
              .where((thumbnail) => thumbnail.name == 'medium')
              .firstOrNull;
          if (thumbnail == null) {
            continue;
          }

          final youtubeToken =
              e.tokens.where((token) => token.type == "youtube").firstOrNull;

          nextUploads.add(NextUpload(
            id: e.id,
            uploadDate: e.uploadDate,
            title: e.title,
            topic: e.topic,
            showId: e.showId,
            showTitle: e.showTitle,
            thumbnailUrl: thumbnail.url,
            youtubeToken: youtubeToken?.token,
          ));
        }
      }

      return nextUploads;
    }

    return [];
  }
}
