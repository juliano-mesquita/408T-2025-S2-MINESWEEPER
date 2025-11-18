import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/pages/game_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        // colorScheme: ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Colors.green,
        //   secondary: Colors.red,
        //   onPrimary: Colors.black,
        //   onSecondary: Colors.teal,
        //   error: Colors.orange,
        //   onError: Colors.white,
        //   surface: Colors.blueGrey,
        //   onSurface: Colors.white,
        // ),
      ),
      home: GameMenu(),
    );
  }
}