import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/game_working_state.dart';

class BoardController {
  final Random random;

  BoardController({Random? random}) : random = random ?? Random();

  void initializeBoard(int width, int height) {
    final gameState = GetIt.instance.get<GameState>();
    final cellCount = width * height;
    final board = Board(
      id: 'board_1',
      width: width,
      height: height,
      cells: List.generate(
        cellCount,
        (index) => Cell(
          adjacentBombs: 0,
          isBomb: false,
          isFlagged: false,
          isRevealed: false,
        ),
      ),
    );

    gameState.board = board;
    gameState.gameWorkingState = GameWorkingState.playing;
  }

  /// Starts opening the board at position [x], [y]
  /// If is first click it'll generate the bombs
  void openAt(int x, int y) {
    final gameState = GetIt.instance.get<GameState>();

    if (gameState.board == null) {
      throw StateError('Board is not initialized');
    }
    final board = gameState.board!;
    assert(x >= 0 && x < board.width);
    assert(y >= 0 && y < board.height);
    if (!gameState.hasHadFirstTap) {
      _placeBombs(x, y);
    }
    _openCell(board, y, x);

    // Update board data
    gameState.board = board;
  }

  void toggleFlagAt(int x, int y) {
    final gameState = GetIt.instance.get<GameState>();

    if (gameState.board == null) {
      throw StateError('Board is not initialized');
    }
    
    final board = gameState.board!;
    assert(x >= 0 && x < board.width);
    assert(y >= 0 && y < board.height);

    final currentCell = board.cellAt(x, y);
    
    if (currentCell.isRevealed) {
      return;
    }

    // Apenas alterna o estado da bandeira
    final updatedCell = currentCell.copyWith(isFlagged: !currentCell.isFlagged);
    board.setCellAt(x, y, updatedCell);

    // Update board data
    gameState.board = board;
  void _openCell(Board board, int row, int col) {
    final rows = board.height;
    final cols = board.width;

    // Verifica se a célula está fora dos limites ou já foi aberta
    if (row < 0 ||
        row >= rows ||
        col < 0 ||
        col >= cols ||
        board.cellAt(col, row).isRevealed) {
      return;
    }

    // Abre a célula
    final newCell = board.cellAt(col, row).copyWith(isRevealed: true);
    board.setCellAt(col, row, newCell);

    final cell = board.cellAt(col, row);

    // Se a célula tem uma mina, não faz nada
    if (cell.isBomb) {
      return;
    }

    // Se a célula não tem minas adjacentes, abre as células vizinhas
    if (cell.adjacentBombs == 0) {
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          if (i != 0 || j != 0) {
            // i - 1 = row - 1
            // i - 0 = row
            // i + 1 = row + 1
            // (col - 1, row - 1), (col + 0, row - 1), (col + 1, row - 1)
            // (col - 1, row + 0), (col + 0, row + 0), (col + 1, row + 0)
            // (col - 1, row + 1), (col + 0, row + 1), (col + 1, row + 1)
            _openCell(board, row + i, col + j);
          }
        }
      }
    }
  }

  /// Places bombs ignoring [tappedX] and [tappedY]
  void _placeBombs(int tappedX, int tappedY) {
    final gameState = GetIt.instance.get<GameState>();
    final board = gameState.board!;
    gameState.hasHadFirstTap = true;
    final bombsToPlace = board.maxBombs;
    final Set<int> bombPositions = {};

    while (bombPositions.length < bombsToPlace) {
      final pos = random.nextInt(board.cells.length);
      // TODO: Lidar com click seguro
      bombPositions.add(pos);
    }
    for (final pos in bombPositions) {
      final x = pos % board.width;
      final y = pos ~/ board.width;

      board.setCellAt(x, y, board.cells[pos].copyWith(isBomb: true));
    }

    // After placing bombs, update adjacent bomb counts
    _calculateAdjacentMines(board);
  }

  /// Calculates adjancent mines in [board]
  Board _calculateAdjacentMines(Board board) {
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
        if (board.cellAt(x, y).isBomb) {
          // Skip bomb cells
          continue;
        }

        int count = 0;
        for (int dy = -1; dy <= 1; dy++) {
          for (int dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0) {
              continue; // Skip the current cell
            }
            final nx = x + dx;
            final ny = y + dy;
            if (nx >= 0 && nx < board.width && ny >= 0 && ny < board.height) {
              if (board.cellAt(nx, ny).isBomb) {
                count++;
              }
            }
          }
        }

        final newCell = board.cellAt(x, y).copyWith(adjacentBombs: count);
        board.setCellAt(x, y, newCell);
      }
    }
    return board;
  }
}
