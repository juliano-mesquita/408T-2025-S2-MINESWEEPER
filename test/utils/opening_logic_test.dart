import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/utils/opening_logic.dart';

void main() {
  group('MinesweeperBoard', () {
    test('Abre uma célula sem minas', () {
      final board = MinesweeperBoard(3, 3);

      board.openCell(1, 1);

      expect(board.board[1][1].isOpen, isTrue);
    });

    test('Não abre células fora dos limites', () {
      final board = MinesweeperBoard(3, 3);

      board.openCell(-1, -1); // Fora dos limites
      board.openCell(3, 3); // Fora dos limites

      for (var row in board.board) {
        for (var cell in row) {
          expect(cell.isOpen, isFalse);
        }
      }
    });

    test('verifica isOpened & isClosed 5x5', () {
      final board = MinesweeperBoard(5, 5);

      // Adiciona uma mina
      board.board[2][3].hasMine = true;
      board.board[3][2].hasMine = true;

      board.calculateAdjacentMines();

      // Abre uma célula sem minas
      board.openCell(1, 1);

      for (int i = 0; i < board.rows; i++) {
        final row = board.board[i];
        print(
          '$i : ' +
              row
                  .map(
                    (cell) => cell.isOpen
                        ? (cell.hasMine ? 'M' : cell.adjacentMines)
                        : 'X',
                  )
                  .join(' '),
        );
      }

      final List<List<int>> expectedOpenedIndex = [
        [0, 0],
        [0, 1],
        [0, 2],
        [0, 3],
        [0, 4],
        [1, 0],
        [1, 1],
        [1, 2],
        [1, 3],
        [1, 4],
        [2, 0],
        [2, 1],
        [2, 2],
        [3, 0],
        [3, 1],
        [4, 0],
        [4, 1],
      ];

      final expectedClosedIndex = [
        [2, 3],
        [3, 2],
        [3, 3],
        [3, 4],
        [4, 2],
        [4, 3],
        [4, 4],
        [2, 4],
      ];

      for (int y = 0; y < board.rows; y++) {
        for (int x = 0; x < board.cols; x++) {
          if (expectedOpenedIndex.any(
            (element) => element[0] == x && element[1] == y,
          )) {
            expect(
              board.board[y][x].isOpen,
              isTrue,
              reason: 'Expected cell at ($x, $y) to be open',
            );
          } else if (expectedClosedIndex.any(
            (element) => element[0] == x && element[1] == y,
          )) {
            expect(
              board.board[y][x].isOpen,
              isFalse,
              reason: 'Expected cell at ($x, $y) to be closed',
            );
          }
        }
      }

      // Verifica se as células adjacentes foram abertas
      expect(board.board[2][2].isOpen, isTrue);
      expect(board.board[1][1].isOpen, isTrue);
      expect(board.board[0][0].isOpen, isTrue);
      expect(board.board[1][2].isOpen, isTrue);
      expect(board.board[0][2].isOpen, isTrue);
      expect(board.board[2][0].isOpen, isTrue);
      expect(board.board[2][1].isOpen, isTrue);
      expect(board.board[1][0].isOpen, isTrue);

      // Verifica se a célula com mina não foi aberta
      expect(board.board[3][3].isOpen, isFalse);
    });

    test('verifica isOpened & isClosed 10x7', () {
      final board = MinesweeperBoard(10, 7);

      // Adiciona uma mina
      board.board[2][3].hasMine = true;
      board.board[7][5].hasMine = true;
      board.board[6][1].hasMine = true;

      board.calculateAdjacentMines();

      // Abre uma célula sem minas
      board.openCell(1, 1);

      for (int i = 0; i < board.rows; i++) {
        final row = board.board[i];
        print(
          '$i : ' +
              row
                  .map(
                    (cell) => cell.isOpen
                        ? (cell.hasMine ? 'M' : cell.adjacentMines)
                        : 'X',
                  )
                  .join(' '),
        );
      }

      final List<List<int>> expectedOpenedIndex = [
        [0, 0],
        [0, 1],
        [0, 2],
        [0, 3],
        [0, 4],
        [0, 5],
        [0, 6],
        [1, 0],
        [1, 1],
        [1, 2],
        [1, 3],
        [1, 4],
        [1, 5],
        [1, 6],
        [2, 0],
        [2, 1],
        [2, 2],
        [2, 4],
        [2, 5],
        [2, 6],
        [3, 0],
        [3, 1],
        [3, 2],
        [3, 4],
        [3, 5],
        [3, 6],
        [4, 0],
        [4, 1],
        // X  Y
        [4, 2],
        [4, 4],
        [4, 5],
        [4, 6],
        [5, 0],
        [5, 1],
        [5, 2],
        [5, 3],
        [5, 4],
        [5, 5],
        [5, 6],
        [6, 2],
        [6, 3],
        [6, 4],
        [6, 5],
        [6, 6],
        [7, 0],
        [7, 1],
        [7, 2],
        [7, 3],
        [7, 4],
        [8, 0],
        [8, 1],
        [8, 2],
        [8, 3],
        [8, 4],
        [8, 5],
        [8, 6],
        [9, 0],
        [9, 1],
        [9, 2],
        [9, 3],
        [9, 4],
        [9, 5],
        [9, 6],
      ];

      final expectedClosedIndex = [
        [2, 3],
        [6, 1],
        [6, 0],
        [7, 5],
        [7, 6],
      ];

      for (int y = 0; y < board.rows; y++) {
        for (int x = 0; x < board.cols; x++) {
          if (expectedOpenedIndex.any(
            (element) => element[0] == x && element[1] == y,
          )) {
            expect(
              board.board[x][y].isOpen,
              isTrue,
              reason: 'Expected cell at ($x, $y) to be open',
            );
          } else if (expectedClosedIndex.any(
            (element) => element[0] == x && element[1] == y,
          )) {
            expect(
              board.board[x][y].isOpen,
              isFalse,
              reason: 'Expected cell at ($x, $y) to be closed',
            );
          }
        }
      }

      // Verifica se as células adjacentes foram abertas
    });

    test('Não abre células com minas', () {
      final board = MinesweeperBoard(3, 3);

      // Adiciona uma mina
      board.board[1][1].hasMine = true;

      // Tenta abrir a célula com mina
      board.openCell(1, 1);

      // Verifica se a célula não foi aberta
      expect(board.board[1][1].isOpen, isFalse);
    });
  });

  test('example', () {
    MinesweeperBoard board = MinesweeperBoard(10, 10);

    // Adiciona algumas minas
    board.board[4][4].hasMine = true;
    board.board[6][5].hasMine = true;
    board.board[9][6].hasMine = true;
    board.board[0][0].hasMine = true;
    board.board[9][9].hasMine = true;
    board.board[8][1].hasMine = true;
    board.board[5][3].hasMine = true;
    // board.board[6][6].hasMine = true;

    // Calcula as minas adjacentes
    board.calculateAdjacentMines();

    // Abre uma célula
    board.openCell(3, 9);

    final expectedOpenedIndex = [
      [1, 0],
      [2, 0],
      [3, 0],
      [4, 0],
      [5, 0],
      [6, 0],
      [7, 0],
      [8, 0],
      [9, 0],
      [0, 1],
      [1, 1],
      [2, 1],
      [3, 1],
      [4, 1],
      [5, 1],
      [6, 1],
      [7, 1],
      [8, 1],
      [9, 1],
      [0, 2],
      [1, 2],
      [2, 2],
      [3, 2],
      [4, 2],
      [5, 2],
      [6, 2],
      [7, 2],
      [8, 2],
      [9, 2],
      [0, 3],
      [1, 3],
      [2, 3],
      [3, 3],
      [4, 3],
      [5, 3],
      [6, 3],
      [7, 3],
      [8, 3],
      [9, 3],
      [0, 4],
      [1, 4],
      [2, 4],
      [3, 4],
      [5, 4],
      [6, 4],
      [7, 4],
      [8, 4],
      [9, 4],
      [0, 5],
      [1, 5],
      [2, 5],
      [5, 5],
      [6, 5],
      [7, 5],
      [8, 5],
      [9, 5],
      [0, 6],
      [1, 6],
      [2, 6],
      [6, 6],
      [7, 6],
      [8, 6],
      [9, 6],
      [0, 7],
      [1, 7],
      [2, 7],
      [6, 7],
      [7, 7],
      [8, 7],
      [9, 7],
      [6, 8],
      [7, 8],
      [8, 8],
      [9, 8],
    ];

    for (final expected in expectedOpenedIndex) {
      expect(board.board[expected[1]][expected[0]].isOpen, isTrue);
    }

    // for (int i = 0; i < board.rows; i++) {
    //   final row = board.board[i];
    //   for (int x = 0; x < row.length; x++) {
    //     if (row[x].isOpen) {
    //       // print('x: $x y: $i is opened');
    //       expectedOpenedIndex.add([x, i]);
    //     }
    //   }
    // }
    // print(expectedOpenedIndex);

    // Exibe o estado do tabuleiro
    for (int i = 0; i < board.rows; i++) {
      final row = board.board[i];
      print(
        '$i : ' +
            row
                .map(
                  (cell) => cell.isOpen
                      ? (cell.hasMine ? 'M' : cell.adjacentMines)
                      : 'X',
                )
                .join(' '),
      );
    }
  });
}
