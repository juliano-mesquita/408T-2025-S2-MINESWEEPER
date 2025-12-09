class Cell
{
  final bool isBomb;
  final bool isRevealed;
  final bool isFlagged;
  final int adjacentBombs;

  Cell({
    required this.isBomb,
    required this.isRevealed,
    required this.isFlagged,
    required this.adjacentBombs,
  });

  Cell copyWith({
    bool? isBomb,
    bool? isRevealed,
    bool? isFlagged,
    int? adjacentBombs,
  }) {
    return Cell(
      isBomb: isBomb ?? this.isBomb,
      isRevealed: isRevealed ?? this.isRevealed,
      isFlagged: isFlagged ?? this.isFlagged,
      adjacentBombs: adjacentBombs ?? this.adjacentBombs,
    );
  }

  @override
  String toString() => 'Cell('
    'bomb: $isBomb, '
    'revealed: $isRevealed, '
    'flagged: $isFlagged, '
    'adjacent: $adjacentBombs'
  ')';
}