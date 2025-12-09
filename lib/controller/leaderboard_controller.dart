import 'package:flutter/material.dart';
import '../repository/leaderboard_repository.dart';
import 'package:minesweeper/models/leaderboard.dart';

class LeaderboardController extends ChangeNotifier {
  final LeaderboardRepository _repository;
  List<Leaderboard> _leaderboard = [];

  LeaderboardController(this._repository);
  List<Leaderboard> get leaderboard => _leaderboard;

  // TODO: Inicializar estado buscando informações do repositório
  Future<void> initializeLeaderboard() async {
    try {
      _leaderboard = await _repository.fetchLeaderboard();
      _leaderboard.sort((a, b) => a.seconds.compareTo(b.seconds)); // Sort by fastest time
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      debugPrint('Error fetching leaderboard: $e');
    }
  }

  // TODO: Método para adicionar entrada no leaderboard
  Future<void> addEntry(String id, String name, int time) async {
    try {
      final newEntry = Leaderboard(id: id, playerName: name, seconds: time);
      await _repository.addLeaderboardEntry(newEntry);
      _leaderboard.add(newEntry);
      _leaderboard.sort((a, b) => a.seconds.compareTo(b.seconds)); // Sort by fastest time
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      debugPrint('Error adding leaderboard entry: $e');
    }
  }
}