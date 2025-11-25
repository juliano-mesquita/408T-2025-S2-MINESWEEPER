import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/pages/game_menu.dart';
import 'package:minesweeper/states/game_state.dart';

void main() {
  registerDependencies();
  runApp(const MyApp());
}

void registerDependencies() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<GameState>(GameState());
  getIt.registerSingleton<BoardController>(BoardController());
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
