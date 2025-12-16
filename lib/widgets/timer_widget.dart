import 'package:flutter/material.dart';
import 'package:minesweeper/states/game_state.dart';
import 'package:minesweeper/states/timer_state.dart';

import 'package:watch_it/watch_it.dart';

class TimerWidget extends StatefulWidget with WatchItStatefulWidgetMixin  {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  String _getTimeFormatted(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final timerState = watchPropertyValue<GameState, TimerState>(
      (state) => state.timerState
    );
    return Row(
      children: [
        const Icon(Icons.timer, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          _getTimeFormatted(timerState.secs),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}