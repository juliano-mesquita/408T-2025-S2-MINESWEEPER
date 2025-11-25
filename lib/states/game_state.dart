
import 'package:flutter/material.dart';
import 'package:minesweeper/models/board.dart';

class GameState extends ChangeNotifier
{
  Board? _board;
  Board? get board => _board;

  set board(Board? board)
  {
    _board = board;
    notifyListeners();
  }

  bool _hasHadFirstTap = false;
  bool get hasHadFirstTap => _hasHadFirstTap;

  set hasHadFirstTap(bool value)
  {
    _hasHadFirstTap = value;
    notifyListeners();
  }
}