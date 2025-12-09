import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/game_working_state.dart';
import 'package:watch_it/watch_it.dart';

class MineSweeperBoardWidget extends StatefulWidget with WatchItStatefulWidgetMixin {
  final double cellSize;

  const MineSweeperBoardWidget({
    super.key,
    this.cellSize = 70
  });
  
  @override
  State<StatefulWidget> createState() => MineSweeperBoardWidgetState();
}

class MineSweeperBoardWidgetState extends State<MineSweeperBoardWidget>
{
  final controller = GetIt.I.get<BoardController>();

  @override
  Widget build(BuildContext context) {
    final gameState = watchIt<GameState>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double bottomPadding = 10;

          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight - bottomPadding;

          int columns = (availableWidth / widget.cellSize).floor();
          int lines = (availableHeight / widget.cellSize).floor();
          int totalCells = lines * columns;

          if (gameState.gameWorkingState == GameWorkingState.notStarted) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_)
              {
                gameState.gameWorkingState = GameWorkingState.playing;
                controller.initializeBoard(columns, lines);
              }
            );
            // Todo return no build precisa ser widget.
            // Como não temos uma tela neste momento(ainda não inicializou)
            // podemos retornar um SizedBox sem tamanho
            return SizedBox();
          }

          final board = gameState.board!;

          return Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: 1.0,
              ),
              itemCount: totalCells,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
