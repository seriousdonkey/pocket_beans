import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_beans/domain/entities/channel.dart';
import 'package:pocket_beans/provider.dart';
import 'package:pocket_beans/ui/pages/schedule/schedule_controller.dart';
import 'package:pocket_beans/ui/pages/schedule/widgets/schedule_list.dart';

import 'widgets/channels.dart';

final scheduleListProvider = FutureProvider<List<Channel>>((ref) {
  final scheduleService = ref.watch(scheduleServiceProvider);
  return scheduleService.loadChannels();
});

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SchedulePageState();
}

class SchedulePageState extends ConsumerState<SchedulePage> {
  bool showChannels = true;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<ScheduleState> state =
        ref.watch(scheduleControllerProvider);

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.black87),
      child: Scaffold(
        body: SafeArea(
          child: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      color: Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Channels(
                            channels: state.value?.channels ?? [],
                            selectedChannel: state.value?.selectedChannel,
                            show: showChannels,
                            onChannelChanged: (channel) => ref
                                .read(scheduleControllerProvider.notifier)
                                .selectChannel(channel),
                          ),
                          Text(
                            state.value?.selectedChannel?.name ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ScheduleList(
                      schedule: state.value?.selectedChannel?.schedule,
                      onScroll: (offset) {
                        bool show;
                        if (offset <= 50) {
                          show = true;
                        } else {
                          show = false;
                        }

                        setState(() {
                          showChannels = show;
                        });
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
