import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/controller/board_controller.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/states/game_state.dart';

void main() {
  group('BoardController', () {
    final int randomSeed = 0;
    late Random random;
    late BoardController boardController;
    late GameState gameState;

    setUp(() {
      random = Random(randomSeed);
      boardController = BoardController(random: random);
      gameState = GetIt.I.registerSingleton(GameState());
    });

    tearDown(() {
      GetIt.I.unregister<GameState>();
    });

    test('initializeBoard creates a board with correct dimensions', () {
      const width = 10;
      const height = 10;

      boardController.initializeBoard(width, height);
      final board = gameState.board;

      expect(board, isNotNull);
      expect(board!.width, equals(width));
      expect(board.height, equals(height));
      expect(board.cells.length, equals(width * height));
      expect(
        board.cells.any((cell) => cell.isBomb),
        isFalse,
        reason: 'Default state should not contain bombs',
      );
      expect(
        board.cells.any((cell) => cell.adjacentBombs != 0),
        isFalse,
        reason: 'Default state should not contain adjacent bombs',
      );
      expect(
        board.cells.any((cell) => cell.isFlagged),
        isFalse,
        reason: 'Default state should not contain flags',
      );
      expect(
        board.cells.any((cell) => cell.isRevealed),
        isFalse,
        reason: 'Default state should not contain revealed cells',
      );
    });

    group('open cell', () {
      group('first tap', () {
        test('sets hasHadFirstTap to true on first openAt call', () {
          const width = 10;
          const height = 10;

          boardController.initializeBoard(width, height);
          expect(gameState.hasHadFirstTap, isFalse);

          boardController.openAt(0, 0);
          expect(gameState.hasHadFirstTap, isTrue);
        });

        group('bomb generation', () {
          test('has exactly maxBombs bombs after first tap', () {
            const width = 10;
            const height = 10;
            boardController.initializeBoard(width, height);
            boardController.openAt(0, 0);
            final board = gameState.board!;
            final bombCount = board.cells.where((cell) => cell.isBomb).length;
            expect(bombCount, equals(board.maxBombs));
          });

          test('bombs are correctly placed', () {
            const width = 10;
            const height = 10;
            boardController.initializeBoard(width, height);
            boardController.openAt(0, 0);
            final board = gameState.board!;

            final expectedBombIndices = <int>[];
            final random = Random(
              randomSeed,
            ); // Reset random to ensure predictable placements
            while (expectedBombIndices.length < board.maxBombs) {
              expectedBombIndices.add(random.nextInt(board.cells.length));
            }
            expectedBombIndices.sort();

            final bombIndices = <int>[];
            for (int i = 0; i < board.cells.length; i++) {
              if (board.cells[i].isBomb) {
                bombIndices.add(i);
              }
            }
            expect(bombIndices, equals(expectedBombIndices));
          });
        });

        group('adjacent bombs', () {
          test('should calculate adjacent bombs correctly', () {
            const width = 5;
            const height = 5;
            boardController.initializeBoard(width, height);

            // Manually place bombs for a predictable setup
            final board = gameState.board!;
            board.setCellAt(1, 1, board.cellAt(1, 1).copyWith(isBomb: true));
            board.setCellAt(3, 3, board.cellAt(3, 3).copyWith(isBomb: true));
            board.setCellAt(2, 2, board.cellAt(2, 2).copyWith(isBomb: true));

            // Trigger adjacent bomb calculation
            boardController.openAt(0, 0);

            board.printBoard();

            // Verify adjacent bomb counts
            expect(board.cellAt(0, 0).adjacentBombs, equals(2));
            expect(board.cellAt(1, 0).adjacentBombs, equals(2));
            expect(board.cellAt(2, 0).adjacentBombs, equals(1));
            expect(board.cellAt(3, 0).adjacentBombs, equals(1));
            expect(board.cellAt(4, 0).adjacentBombs, equals(1));

            expect(board.cellAt(0, 1).isBomb, isTrue);
            expect(board.cellAt(1, 1).isBomb, isTrue);
            expect(board.cellAt(2, 1).adjacentBombs, equals(2));
            expect(board.cellAt(3, 1).adjacentBombs, equals(3));
            expect(board.cellAt(4, 1).isBomb, isTrue);

            expect(board.cellAt(0, 2).adjacentBombs, equals(2));
            expect(board.cellAt(1, 2).adjacentBombs, equals(3));
            expect(board.cellAt(2, 2).isBomb, isTrue);
            expect(board.cellAt(3, 2).adjacentBombs, equals(4));
            expect(board.cellAt(4, 2).isBomb, isTrue);

            expect(board.cellAt(0, 3).adjacentBombs, equals(0));
            expect(board.cellAt(1, 3).adjacentBombs, equals(1));
            expect(board.cellAt(2, 3).adjacentBombs, equals(2));
            expect(board.cellAt(3, 3).isBomb, isTrue);
            expect(board.cellAt(4, 3).adjacentBombs, equals(2));

            expect(board.cellAt(0, 4).adjacentBombs, equals(0));
            expect(board.cellAt(1, 4).adjacentBombs, equals(0));
            expect(board.cellAt(2, 4).adjacentBombs, equals(1));
            expect(board.cellAt(3, 4).adjacentBombs, equals(1));
            expect(board.cellAt(4, 4).adjacentBombs, equals(1));
          });
        });
      });

      test('Abre uma célula sem minas', () {
        boardController.initializeBoard(3, 3);
        final board = gameState.board!;

        boardController.openAt(1, 1);

        expect(board.cellAt(1, 1).isRevealed, isTrue);
      });

      test('Não abre células fora dos limites', () {
        boardController.initializeBoard(5, 5);

        final gameState = GetIt.instance.get<GameState>();
        final board = gameState.board!;

        expect(
          () => boardController.openAt(-1, -1),
          throwsA(isA<AssertionError>()),
        );
      });

      test('verifica isOpened & isClosed 5x5', () {
        boardController.initializeBoard(5, 5);

        final gameState = GetIt.instance.get<GameState>();

        final board = gameState.board!;

        // Abre uma célula sem minas
        boardController.openAt(0, 0);
        //    boardController.openAt(3, 3);

        for (int y = 0; y < board.height; y++) {
          List<Cell> row = [];
          for (int x = 0; x < board.width; x++) {
            final cell = board.cellAt(x, y);
            row.add(cell);
          }
          debugPrint(
            '$y : ${row.map((cell) => !cell.isRevealed ? (cell.isBomb ? 'M' : 'X') : cell.adjacentBombs).join(' ')}',
          );
        }

        final List<List<int>> expectedOpenedIndex = [
          [0, 0],
        ];

        for (int y = 0; y < board.height; y++) {
          for (int x = 0; x < board.width; x++) {
            final shouldBeReveleaed = expectedOpenedIndex.any(
              (element) => element[0] == x && element[1] == y,
            );
            expect(
              board.cellAt(x, y).isRevealed,
              equals(shouldBeReveleaed),
              reason:
                  'Expected cell at ($x, $y) to be ${shouldBeReveleaed ? 'Opened' : 'Closed'}',
            );
          }
        }
      });

      test('verifica isOpened & isClosed 10x7', () {
        boardController.initializeBoard(7, 10);
        final gameState = GetIt.instance.get<GameState>();

        final board = gameState.board!;

        // Abre uma célula sem minas
        //boardController.openAt(0, 0);
        boardController.openAt(6, 6);

        for (int y = 0; y < board.height; y++) {
          List<Cell> row = [];
          for (int x = 0; x < board.width; x++) {
            final cell = board.cellAt(x, y);
            row.add(cell);
          }
          debugPrint(
            '$y : ${row.map((cell) => !cell.isRevealed ? (cell.isBomb ? 'M' : 'X') : cell.adjacentBombs).join(' ')}',
          );
        }

        final List<List<int>> expectedOpenedIndex = [
          [6, 6],
          [5, 5],
          [6, 5],
          [3, 6],
          [4, 6],
          [5, 6],
          [3, 7],
          [4, 7],
          [5, 7],
          [6, 7],
          [3, 8],
          [4, 8],
          [5, 8],
          [6, 8],
          [3, 9],
          [4, 9],
          [5, 9],
          [6, 9],
        ];

        for (int y = 0; y < board.height; y++) {
          for (int x = 0; x < board.width; x++) {
            final shouldBeReveleaed = expectedOpenedIndex.any(
              (element) => element[0] == x && element[1] == y,
            );
            expect(
              board.cellAt(x, y).isRevealed,
              equals(shouldBeReveleaed),
              reason:
                  'Expected cell at ($x, $y) to be ${shouldBeReveleaed ? 'Opened' : 'Closed'}',
            );
          }
        }

        // Verifica se as células adjacentes foram abertas
      });

      test('Não abre células com minas', () {
        boardController.initializeBoard(7, 10);
        final gameState = GetIt.instance.get<GameState>();

        final board = gameState.board!;

        // Abre uma célula sem minas
        //boardController.openAt(0, 0);
        boardController.openAt(6, 6);

        for (int y = 0; y < board.height; y++) {
          List<Cell> row = [];
          for (int x = 0; x < board.width; x++) {
            final cell = board.cellAt(x, y);
            row.add(cell);
          }
          debugPrint(
            '$y : ${row.map((cell) => !cell.isRevealed ? (cell.isBomb ? 'M' : 'X') : cell.adjacentBombs).join(' ')}',
          );
        }

        final List<List<int>> expectedOpenedIndex = [
          [6, 6],
          [5, 5],
          [6, 5],
          [3, 6],
          [4, 6],
          [5, 6],
          [3, 7],
          [4, 7],
          [5, 7],
          [6, 7],
          [3, 8],
          [4, 8],
          [5, 8],
          [6, 8],
          [3, 9],
          [4, 9],
          [5, 9],
          [6, 9],
        ];
        for (int y = 0; y < board.height; y++) {
          for (int x = 0; x < board.width; x++) {
            final shouldBeReveleaed = expectedOpenedIndex.any(
              (element) => element[0] == x && element[1] == y,
            );
            expect(board.cellAt(0, 1).isRevealed, isFalse);
          }
        }
      });
    });
  });
}
