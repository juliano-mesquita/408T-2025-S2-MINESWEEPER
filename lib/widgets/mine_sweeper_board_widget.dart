
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/models/cell_state.dart';
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
  Map<int, CellState> cellStates = {};

  void toggleFlag(int index) {
    setState(() {
      if (cellStates[index] == null) {
        cellStates[index] = CellState();
      }
      
      if (!cellStates[index]!.isRevealed) {
        cellStates[index]!.isFlagged = !cellStates[index]!.isFlagged;
      }
    });
  }

  void revealCell(int index) {
    setState(() {
      if (cellStates[index] == null) {
        cellStates[index] = CellState();
      }
      
      if (!cellStates[index]!.isFlagged) {
        cellStates[index]!.isRevealed = true;
      }
    });
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