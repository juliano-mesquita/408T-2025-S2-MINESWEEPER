import 'package:flutter/material.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/game_working_state.dart';
import 'package:minesweeper/widgets/cell_widget.dart';
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
  final boardController = GetIt.instance.get<BoardController>();
  final gameState = GetIt.instance.get<GameState>();  

  void toggleFlag(int index) {
    // 1D(index) => 2D(x, y)
    final x = index % gameState.board!.width;
    final y = index ~/ gameState.board!.width;
   boardController.toggleFlagAt(x, y);
  }

  void revealCell(int index) {
    final cell = gameState.board!.cells[index];

    if(cell.isFlagged)
    {
      return;
    }

    final x = index % gameState.board!.width;
    final y = index ~/ gameState.board!.width;
    boardController.openAt(x, y);
  }

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

          if (gameState.gameWorkingState == GameWorkingState.notStarted && gameState.board == null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_)
              {
                boardController.initializeBoard(columns, lines);
              }
            );
            // Todo return no build precisa ser widget.
            // Como não temos uma tela neste momento(ainda não inicializou)
            // podemos retornar um SizedBox sem tamanho
            return SizedBox();
          }

          if(gameState.board == null)
          {
            return const SizedBox();
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
                final x = index % board.width;
                final y = index ~/ board.width;

                final cell = board.cellAt(x, y);

                return CellWidget(
                  revealCell: () => revealCell(index),
                  toggleFlag: () => toggleFlag(index),
                  cellSize: widget.cellSize,
                  isRevealed:cell.isRevealed,
                  isFlagged: cell.isFlagged,
                  neighborMines: cell.adjacentBombs,
                  hasMine: cell.isBomb,
                );
              },
            ),
          );
        }
      )
    );
  }
}
