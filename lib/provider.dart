import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_beans/data/repositories/schedule_repository_impl.dart';
import 'package:pocket_beans/services/schedule_service.dart';

// Repositories
final scheduleRepositoryProvider = Provider((_) => ScheduleRepositoryImpl());

// Services
final scheduleServiceProvider = Provider((ref) =>
    ScheduleService(scheduleRepository: ref.watch(scheduleRepositoryProvider)));
