import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget
{
  final double cellSize;
  final void Function() revealCell;
  final void Function() toggleFlag;

  final bool isRevealed;
  final bool isFlagged;

  const CellWidget({
    super.key,
    required this.revealCell,
    required this.toggleFlag,
    required this.cellSize,
    this.isFlagged = false,
    this.isRevealed = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: revealCell,
      onLongPress: toggleFlag,
      child: Container(
        decoration: BoxDecoration(
          color: isRevealed 
              ? Colors.grey[400] 
              : Colors.blue[300],
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: isFlagged
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