import 'package:flutter/material.dart';
import 'package:minesweeper/pages/flag.dart';

class CellWidget extends StatelessWidget
{
  final double cellSize;
  final void Function() revealCell;
  final void Function() toggleFlag;

  const CellWidget({
    super.key,
    required this.revealCell,
    required this.toggleFlag,
    required this.cellSize
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: revealCell,
      onLongPress: toggleFlag,
      child: Container(
        decoration: BoxDecoration(
          color: CellState().isRevealed 
              ? Colors.grey[400] 
              : Colors.blue[300],
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: CellState().isFlagged
            ? Icon(
                Icons.flag,
                color: Colors.red,
                size: cellSize * 0.5,
              )
            : null,
      ),
    );
  }
}