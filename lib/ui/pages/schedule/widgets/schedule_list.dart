import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pocket_beans/ui/pages/schedule/widgets/schedule_item.dart';

import '../../../../domain/entities/schedule_entry.dart';

class ScheduleList extends ConsumerWidget {
  final Map<DateTime, List<ScheduleEntry>>? schedule;
  final Function onScroll;

  final ScrollController _scrollController = ScrollController();

  ScheduleList({
    super.key,
    required this.schedule,
    required this.onScroll,
  }) {
    _scrollController.addListener(() {
      onScroll(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (schedule == null) {
      return Container();
    }

    if (schedule!.isEmpty) {
      return const Center(
        child: Text('Keine Sendeinformationen vorhanden'),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: schedule!.length,
          itemBuilder: (ctx, idx) {
            final date = schedule!.keys.elementAt(idx);
            final schedules = schedule![date];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(DateFormat('EEEE, dd.MM', 'de_DE').format(date)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: schedules!.length,
                  itemBuilder: (ctx, scheduleIdx) {
                    final item = schedules[scheduleIdx];
                    return ScheduleItem(
                      item: item,
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
