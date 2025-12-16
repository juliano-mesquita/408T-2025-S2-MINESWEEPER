import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/game_working_state.dart';
import 'package:minesweeper/states/timer_state.dart';
import 'package:minesweeper/repository/settings_repository.dart';

class GameController {
  final state = GetIt.instance.get<GameState>();
  final settingsRepository = GetIt.instance.get<SettingsRepository>();
  Timer? _timer;

  Future<void> init() async
  {
    final difficulty = await settingsRepository.loadDifficulty();
    state.gameDifficulty = difficulty;
    state.addListener(_onGameStateUpdate);
  }

  void dispose()
  {
    state.removeListener(_onGameStateUpdate);
    if(_timer != null && _timer!.isActive)
    {
      _timer?.cancel();
    }
  }

  void startGame() {
    if (state.gameWorkingState != GameWorkingState.notStarted)
    {
      return;
    }
    _startTimer();
    state.gameWorkingState = GameWorkingState.playing;
  }

  void pauseGame() {
    _timer?.cancel();
    final timerState = TimerState();
    timerState.isRunning = false;
    timerState.secs = state.timerState.secs;
    state.timerState = timerState;
  }

  void resumeGame() {
    _startTimer();
  }

  void finishGame() {
    final timerState = TimerState();
    
    state.hasHadFirstTap = false;
    state.gameWorkingState = GameWorkingState.notStarted;
    state.board = null;

    
    timerState.isRunning = false;
    timerState.secs = 0;
    state.timerState = timerState;
  }

  void _startTimer()
  {
    final timerState = TimerState();
    timerState.secs = 0;
    timerState.isRunning = true;
    state.timerState = timerState;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final timerState = TimerState();
        timerState.isRunning = state.timerState.isRunning;
        timerState.secs = state.timerState.secs + 1;
        state.timerState = timerState;
      }
    );
  }

  void _onGameStateUpdate()
  {
    if(state.hasHadFirstTap && !state.timerState.isRunning)
    {
      startGame();
    }
    if(_timer != null && _timer!.isActive && state.gameWorkingState != GameWorkingState.playing)
    {
      pauseGame();
    }
    _duringGamePlay();
  }

  void _duringGamePlay()
  {
    final currentState = state;
    if(currentState.gameWorkingState != GameWorkingState.playing || currentState.board == null)
    {
      return;
    }
    int flaggedBombs = 0;
    int reveleadNonBombs = 0;
    final maxBombs = currentState.board?.maxBombs ?? 0;
    for(final Cell cell in currentState.board?.cells ?? [])
    {
      if(cell.isBomb && cell.isRevealed)
      {
        state.gameWorkingState = GameWorkingState.gameOver;
        break;
      }
      else if(cell.isBomb && cell.isFlagged)
      {
        flaggedBombs++;
      }
      else if(!cell.isBomb && cell.isRevealed)
      {
        reveleadNonBombs++;
      }
    }
  
    if(flaggedBombs == maxBombs || reveleadNonBombs == currentState.board!.cells.length - maxBombs)
    {
      state.gameWorkingState = GameWorkingState.victory;
    }
  }

  Future<void> setDifficulty(GameDifficulty difficulty) async
  {
    await settingsRepository.saveDifficulty(difficulty);
    state.gameDifficulty = difficulty;
  }
}