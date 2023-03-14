import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_beans/provider.dart';
import 'package:pocket_beans/services/schedule_service.dart';

import '../../../domain/entities/channel.dart';

final scheduleControllerProvider = StateNotifierProvider.autoDispose<
    ScheduleController, AsyncValue<ScheduleState>>((ref) {
  final ScheduleService scheduleService = ref.watch(scheduleServiceProvider);

  return ScheduleController(scheduleService: scheduleService);
});

class ScheduleState extends Equatable {
  final List<Channel> channels;
  final Channel? selectedChannel;

  const ScheduleState({
    this.channels = const [],
    this.selectedChannel,
  });

  @override
  List<Object?> get props => [channels, selectedChannel];

  ScheduleState copyWith({
    List<Channel>? channels,
    Channel? selectedChannel,
  }) {
    return ScheduleState(
      channels: channels ?? this.channels,
      selectedChannel: selectedChannel ?? this.selectedChannel,
    );
  }
}

class ScheduleController extends StateNotifier<AsyncValue<ScheduleState>> {
  ScheduleController({required this.scheduleService})
      : super(const AsyncValue.loading()) {
    loadChannels();
  }

  final ScheduleService scheduleService;

  Future<void> loadChannels() async {
    state = const AsyncLoading();

    final channels = await scheduleService.loadChannels();
    state = AsyncValue.data(
        ScheduleState(channels: channels, selectedChannel: channels[0]));
  }

  Future<void> selectChannel(Channel channel) async {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(selectedChannel: channel));
    }
  }
}
