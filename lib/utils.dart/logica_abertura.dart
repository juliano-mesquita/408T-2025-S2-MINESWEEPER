class Cell {
  bool hasMine;
  bool isOpen;
  int adjacentMines;

  Cell({this.hasMine = false, this.isOpen = false, this.adjacentMines = 0});
}

class MinesweeperBoard {
  final int rows;
  final int cols;
  late List<List<Cell>> board;

  MinesweeperBoard(this.rows, this.cols) {
    board = List.generate(rows, (_) => List.generate(cols, (_) => Cell()));
  }

  void openCell(int row, int col) {
    // Verifica se a célula está fora dos limites ou já foi aberta
    if (row < 0 ||
        row >= rows ||
        col < 0 ||
        col >= cols ||
        board[row][col].isOpen) {
      return;
    }

    // Abre a célula
    board[row][col].isOpen = true;

    // Se a célula tem uma mina, não faz nada
    if (board[row][col].hasMine) {
      return;
    }

    // Se a célula não tem minas adjacentes, abre as células vizinhas
    if (board[row][col].adjacentMines == 0) {
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          if (i != 0 || j != 0) {
            // i - 1 = row - 1
            // i - 0 = row
            // i + 1 = row + 1
            // (col - 1, row - 1), (col + 0, row - 1), (col + 1, row - 1)
            // (col - 1, row + 0), (col + 0, row + 0), (col + 1, row + 0)
            // (col - 1, row + 1), (col + 0, row + 1), (col + 1, row + 1)
            openCell(row + i, col + j);
          }
        }
      }
    }
  }

  void calculateAdjacentMines() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (board[row][col].hasMine) {
          continue;
        }

        int count = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            int newRow = row + i;
            int newCol = col + j;
            if (newRow >= 0 &&
                newRow < rows &&
                newCol >= 0 &&
                newCol < cols &&
                board[newRow][newCol].hasMine) {
              count++;
            }
          }
        }
        board[row][col].adjacentMines = count;
      }
    }
  }
}

void main() {
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
}
