import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minesweeper/models/leaderboard.dart';

class LeaderboardRepository {
  static const String _leaderboardKey = 'leaderboard';

  // Fetch leaderboard data from shared_preferences
  Future<List<Leaderboard>> fetchLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboardJson = prefs.getString(_leaderboardKey);

    if (leaderboardJson == null) {
      return []; // Return an empty list if no data is found
    }

    final List<dynamic> leaderboardMap = jsonDecode(leaderboardJson);
    return leaderboardMap
        .map((entry) => Leaderboard.fromJson(entry))
        .toList();
  }

  // Add a new entry to the leaderboard and save it
  Future<void> addLeaderboardEntry(Leaderboard entry) async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboard = await fetchLeaderboard();

    leaderboard.add(entry);
    leaderboard.sort((a, b) => a.seconds.compareTo(b.seconds)); // Sort by fastest time

    final leaderboardJson = jsonEncode(leaderboard.map((e) => e.toJson()).toList());
    await prefs.setString(_leaderboardKey, leaderboardJson);
  }

  // Clear the leaderboard data
  Future<void> clearLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_leaderboardKey);
  }
}