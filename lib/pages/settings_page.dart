import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/repository/settings_repository.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:watch_it/watch_it.dart';

class SettingsPage extends StatefulWidget with WatchItStatefulWidgetMixin {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final gameController = GetIt.instance.get<GameController>();

  @override
  Widget build(BuildContext context) {
    final gameDifficulty = watchPropertyValue<GameState, GameDifficulty>(
      (state) => state.gameDifficulty,
    );
    final selectedDifficulty = GameDifficulty.values
        .map((difficulty) => difficulty == gameDifficulty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.labelSettings),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.labelDifficultySelector,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ToggleButtons(
                  direction: Axis.vertical,
                  onPressed: (int index) {
                    gameController.setDifficulty(GameDifficulty.values[index]);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.black,
                  fillColor: Colors.red[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 90.0,
                  ),
                  isSelected: selectedDifficulty,
                  children: GameDifficulty.values
                      .map(
                        (difficulty) => Text(switch (difficulty) {
                          GameDifficulty.medium => AppLocalizations.of(
                            context,
                          )!.labelDifficultyMedium,
                          GameDifficulty.hard => AppLocalizations.of(
                            context,
                          )!.labelDifficultyHard,
                          GameDifficulty.easy => AppLocalizations.of(
                            context,
                          )!.labelDifficultyEasy,
                        }),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
