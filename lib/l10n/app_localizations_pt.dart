// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get titleGameMenu => 'Menu do jogo!';

  @override
  String get btnStartGame => 'Inicio do jogo!';

  @override
  String get btnSettings => 'Configurações!';

  @override
  String get btnRankings => 'Rankings!';

  @override
  String get titleBoard => 'Tabuleiro!';

  @override
  String get titleGameOver => 'Game Over';

  @override
  String get btnGoMainMenu => 'Voltar ao menu principal';

  @override
  String get titleVictory => 'Victory';

  @override
  String get labelDifficultyHard => 'Díficil';

  @override
  String get labelDifficultyMedium => 'Médio';

  @override
  String get labelDifficultyEasy => 'Fácil';

  @override
  String get labelDifficultySelector => 'Selecione o Nível de Dificuldade';

  @override
  String get labelSettings => 'Configurações';
  String get btnLeave => 'Sair';
}
