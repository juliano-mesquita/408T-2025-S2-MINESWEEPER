import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/cell.dart';

class Board
{
  final String id;
  final List<Cell> cells;

  final int width;
  final int height;


  final double bombCountModifier;

  int get maxBombs => ((width * height) * bombCountModifier).round();

  Board({
    required this.id,
    required this.cells,
    required this.width,
    required this.height,
    this.bombCountModifier = 0.13 //Easy mode
  });

  // todo: copyWith method
  Board copyWith({
    String? id,
    List<Cell>? cells,
    int? width,
    int? height,
    double? bombCountModifier
  }) {
    return Board(
      id: id ?? this.id,
      cells: cells ?? this.cells.map((e) => e.copyWith()).toList(),
      width: width ?? this.width,
      height: height ?? this.height,
      bombCountModifier: bombCountModifier ?? this.bombCountModifier
    );
  }

  /// Returns the cell located at [x, y]
  Cell cellAt(int x, int y)
  {
    assert(x >= 0 && x < width, 'x out of bounds');
    assert(y >= 0 && y < height, 'y out of bounds');
    return cells[y * width + x];
  }

  /// Returns the cell located at [x, y]
  void setCellAt(int x, int y, Cell cell)
  {
    assert(x >= 0 && x < width, 'x out of bounds');
    assert(y >= 0 && y < height, 'y out of bounds');
    cells[y * width + x] = cell;
  }

  void printBoard()
  {
    StringBuffer buffer = StringBuffer();
    for(int y = 0; y < height; y++)
    {
      for(int x = 0; x < width; x++)
      {
        final cell = cellAt(x, y);
        if(cell.isBomb)
        {
          buffer.write(' B ');
        }
        else
        {
          buffer.write(' ${cell.adjacentBombs} ');
        }
      }
      buffer.write('\n');
    }
    debugPrint(buffer.toString());
  }

  @override
  String toString() => 'Board('
    'id: $id, '
    'width: $width, '
    'height: $height, '
    'cells: $cells' 
  ')';
}