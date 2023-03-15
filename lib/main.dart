import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_beans/ui/pages/schedule/schedule_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('de');
  runApp(const ProviderScope(child: PocketBeansApp()));
}

class PocketBeansApp extends ConsumerWidget {
  const PocketBeansApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pocket Beans',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.red,
          ),
        ),
        scaffoldBackgroundColor: Colors.black87,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black87,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromRGBO(230, -0, 6, 1),
            brightness: Brightness.dark),
      ),
      home: const SchedulePage(),
    );
  }
}
