import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_beans/ui/pages/schedule/schedule_page.dart';

void main() {
  runApp(ProviderScope(child: PocketBeansApp()));
}

class PocketBeansApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pocket Beans',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.black87,
          foregroundColor: Colors.black87,
          surfaceTintColor: Colors.black87,
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
