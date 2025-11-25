
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';

class MineSweeperBoardWidget extends StatelessWidget
{
  final double cellSize;

  const MineSweeperBoardWidget({
    super.key,
    this.cellSize = 70
  });

  @override
  Widget build(BuildContext context)
  {
    return LayoutBuilder(
      builder: (context, constraints) {
        double bottomPadding = 10;

        double availableWidth = constraints.maxWidth;
        double availableHeight = constraints.maxHeight - bottomPadding;

        int columns = (availableWidth / cellSize).floor();
        int lines = (availableHeight / cellSize).floor();

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
    );
  }
  
}