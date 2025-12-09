import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/states/game_state.dart';

class BoardController
{
  final Random random;

  BoardController({Random? random})
    : random = random ?? Random();

  void initializeBoard(int width, int height)
  {
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
          isRevealed: false
        )
      ),
    );

    gameState.board = board;
  }

  /// Starts opening the board at position [x], [y]
  /// If is first click it'll generate the bombs
  void openAt(int x, int y)
  {
    final gameState = GetIt.instance.get<GameState>();

    if(gameState.board == null) {
      throw StateError('Board is not initialized');
    }
    final board = gameState.board!;
    assert(x >= 0 && x < board.width);
    assert(y >= 0 && y < board.height);
    if(!gameState.hasHadFirstTap)
    {
      _placeBombs(x, y);
    }
    // TODO: Open cells around the tap if needed

    // Update board data
    gameState.board = board;
  }

  /// Places bombs ignoring [tappedX] and [tappedY]
  void _placeBombs(int tappedX, int tappedY)
  {
    final gameState = GetIt.instance.get<GameState>();
    final board = gameState.board!;
    gameState.hasHadFirstTap = true;
    final bombsToPlace = board.maxBombs;
    final Set<int> bombPositions = {};
    final Set <int> safePositions = {};
    
    // Adicionar célula clicada
    final tappedPos = tappedY * board.width + tappedX;
    safePositions.add(tappedPos);
    
    // Adicionar os 8 vizinhos (área 3x3)
    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        final nx = tappedX + dx;
        final ny = tappedY + dy;
        
        if (nx >= 0 && nx < board.width && ny >= 0 && ny < board.height) {
          final pos = ny * board.width + nx;
          safePositions.add(pos);
        }
      }
    }

    // Gerar bombas fora da área segura
    while(bombPositions.length < bombsToPlace)
    {
      final pos = random.nextInt(board.cells.length);

      if (safePositions.contains(pos)){
        continue;
      }

      bombPositions.add(pos);
    }

    for(final pos in bombPositions)
    {
      final x = pos % board.width;
      final y = pos ~/ board.width;

      board.setCellAt(x, y, board.cells[pos].copyWith(isBomb: true));
    }
    
    // After placing bombs, update adjacent bomb counts
    _calculateAdjacentMines(board);
  }

  /// Calculates adjancent mines in [board]
  Board _calculateAdjacentMines(Board board)
  {
    for (int y = 0; y < board.height; y++)
    {
      for (int x = 0; x < board.width; x++)
      {
        if (board.cellAt(x, y).isBomb)
        {
          // Skip bomb cells
          continue;
        }

        int count = 0;
        for (int dy = -1; dy <= 1; dy++)
        {
          for (int dx = -1; dx <= 1; dx++)
          {
            if (dx == 0 && dy == 0)
            {
              continue; // Skip the current cell
            }
            final nx = x + dx;
            final ny = y + dy;
            if (nx >= 0 &&
                nx < board.width &&
                ny >= 0 && 
                ny < board.height
            )
            {
              if (board.cellAt(nx, ny).isBomb)
              {
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