import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/pages/game_menu.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/repository/settings_repository.dart';

void main() async {
  await registerDependencies();
  runApp(const MyApp());
}

Future<void> registerDependencies() async {
  final getIt = GetIt.instance;
  getIt.registerSingleton<GameState>(GameState());
  getIt.registerSingleton<BoardController>(BoardController());
  getIt.registerSingleton<SettingsRepository>(SettingsRepository());
  getIt.registerSingletonAsync<GameController>(
    () async
    {
      final instance = GameController();
      await instance.init();
      return instance;
    },
    dispose: (instance) => instance.dispose(),
  );
  await getIt.allReady();
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
