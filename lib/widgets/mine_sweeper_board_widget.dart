
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/widget/cell_widget.dart';

class MineSweeperBoardWidget extends StatefulWidget
{
  final double cellSize;

  const MineSweeperBoardWidget({
    super.key,
    this.cellSize = 70
  });

  
  
  @override
  State<MineSweeperBoardWidget> createState() => _MineSweeperBoardWidgetState();
}

class _MineSweeperBoardWidgetState extends State<MineSweeperBoardWidget>
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
    final x = index % gameState.board!.width;
    final y = index ~/ gameState.board!.width;
    boardController.openAt(x, y);
  }

  @override
  Widget build(BuildContext context)
  {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bottomPadding = 10;

        double availableWidth = constraints.maxWidth;
        double availableHeight = constraints.maxHeight - bottomPadding;

        int columns = (availableWidth / widget.cellSize).floor();
        int lines = (availableHeight / widget.cellSize).floor();

        // TODO: Change to start game
        // TODO: Do not render board until game is initialized
        // TODO: Prevent board reinitialization on widget update
        GetIt.instance.get<BoardController>().initializeBoard(columns, lines);

        int totalCells = lines * columns;

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
              return CellWidget(
                revealCell: () => revealCell(index),
                toggleFlag: () => toggleFlag(index),
                cellSize: widget.cellSize
              );
            },
          ),
        );
      },
    );
  }
  
}