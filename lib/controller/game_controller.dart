import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/states/game_state.dart';

class GameController extends ChangeNotifier {
  final state = GetIt.instance.get<GameState>();
  Timer? _timer;

  void startGame() {
    if (state.timerState.isRunning)
    {
      return;
    }
    state.timerState.isRunning = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        state.timerState.secs++;
        notifyListeners();
      }
    ); 
    notifyListeners();
  }

  void pauseGame() {
    _timer?.cancel();
    state.timerState.isRunning = false;
    notifyListeners();
  }

  void resumeGame() {
    startGame();
  }

  void finishGame() {
    _timer?.cancel();
    state.timerState.secs = 0;
    state.timerState.isRunning = false;
    notifyListeners();
  }
}