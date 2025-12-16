import 'package:shared_preferences/shared_preferences.dart';

enum GameDifficulty {
  easy, //'Fácil 8x8'
  medium, // 'Médio 10x10'
  hard, // 'Difícil 12x12'
}

class SettingsRepository {
  static const String _difficultyKey = 'selectedDifficulty';

  Future<void> saveDifficulty(GameDifficulty difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_difficultyKey, difficulty.name);
  }

  Future<GameDifficulty> loadDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDifficulty = prefs.getString(_difficultyKey);

    return GameDifficulty.values.firstWhere(
      (difficulty) => difficulty.name == savedDifficulty,
      orElse: () => GameDifficulty.easy,
    );
  }
}
