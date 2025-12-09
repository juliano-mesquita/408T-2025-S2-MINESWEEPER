import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  final double cellSize;
  final void Function() revealCell;
  final void Function() toggleFlag;

  final bool isRevealed;
  final bool isFlagged;
  final bool hasMine;
  final int neighborMines;

  const CellWidget({
    super.key,
    required this.revealCell,
    required this.toggleFlag,
    required this.cellSize,
    this.isFlagged = false,
    this.isRevealed = false,
    this.hasMine = false,
    this.neighborMines = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: revealCell,
      onLongPress: toggleFlag,
      child: Container(
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: isRevealed ? Colors.grey[400] : Colors.blue[300],
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Stack(
          children: [
            Center(
              child: _buildCellContent(),
            ),
            if (isFlagged)
            Center(
              child: Icon(
                Icons.flag,
                color: Colors.red,
                size: cellSize * 0.5
              )
            )
          ],
        )
      ),
    );
  }

  Widget _buildCellContent() {
    if (!isRevealed) {
      return SizedBox();
    }
    if(hasMine) {
      return Text(
        '💣',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: cellSize * 0.4
        )
      );
    }
    if (neighborMines > 0) {
      return Text(
        "$neighborMines",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: cellSize * 0.4,
          color: _colorForNumber(neighborMines),
        ),
      );
    }
    return SizedBox();
  }

  Color _colorForNumber(int n) {
    switch (n) {
      case 1: return Colors.blue;
      case 2: return Colors.green;
      case 3: return Colors.red;
      case 4: return Colors.purple;
      default: return Colors.black;
    }
  }
}