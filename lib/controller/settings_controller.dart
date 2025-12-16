// import 'package:shared_preferences/shared_preferences.dart';

// // TODO: Settings State(gameDifficulty - Enum)

// enum GameDifficulty { easy, medium, hard }

// class SettingsController {
//   static const String _difficultyKey = 'selectedDifficulty';

//   final List<String> dificuldades = <String>[
//     'Fácil 8x8',
//     'Médio 10x10',
//     'Difícil 12x12',
//   ];

//   Future<void> init() {
//     // TODO: Fetch settings from repository
//     // TODO: Load SettingsState
//   }

//   // Salva a dificuldade selecionada
//   Future<void> saveSelectedDifficulty(String difficulty) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_difficultyKey, difficulty);
//   }

//   // Carrega a dificuldade salva
//   Future<String> loadSelectedDifficulty() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_difficultyKey) ??
//         dificuldades[0]; // Retorna 'Fácil 8x8' como padrão
//   }
// }
