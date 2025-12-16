import 'package:flutter/material.dart';
import 'package:minesweeper/controller/game_controller.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/repository/settings_repository.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/game_working_state.dart';
import 'package:minesweeper/widgets/timer_widget.dart';
import 'package:minesweeper/widgets/mine_sweeper_board_widget.dart';
import 'package:watch_it/watch_it.dart';

class GamePage extends StatefulWidget with WatchItStatefulWidgetMixin {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final gameController = GetIt.instance.get<GameController>();
  final gameState = GetIt.instance.get<GameState>();

  @override
  void dispose()
  {
    super.dispose();
    gameController.finishGame();
  }
  
  @override
  Widget build(BuildContext context) {
    final gameState = watchPropertyValue<GameState, GameWorkingState>((state) => state.gameWorkingState);
    final gameDifficulty = watchPropertyValue<GameState, GameDifficulty>((state) => state.gameDifficulty);
    final cellSize = switch (gameDifficulty) {
      GameDifficulty.easy => 100.0,
      GameDifficulty.medium => 70.0,
      GameDifficulty.hard => 40.0,
    };
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TimerWidget(),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text("Sair"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MineSweeperBoardWidget(cellSize: cellSize)
              )
            ],
          ),
          if(gameState == GameWorkingState.gameOver)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.titleGameOver,
                      style: TextTheme.of(context).headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.btnGoMainMenu),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ),
            ),
          if(gameState == GameWorkingState.victory)
            Container(
              color: Colors.green.withValues(alpha: 0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.titleVictory,
                      style: TextTheme.of(context).headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.btnGoMainMenu),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ),
            )
        ],
      ),
    );
  }
}