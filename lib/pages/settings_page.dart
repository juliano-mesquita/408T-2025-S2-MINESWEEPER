import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/repository/settings_repository.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsRepository _settingsRepository = SettingsRepository();
  GameDifficulty _selectedGameDifficulty = GameDifficulty.easy;
  List<bool> get _selectedDifficulty => GameDifficulty.values
      .map((difficulty) => difficulty == _selectedGameDifficulty)
      .toList();

  @override
  void initState() {
    super.initState();
    _loadSelectedDifficulty(); //carregar a dificuldade salva
  }

  Future<void> _loadSelectedDifficulty() async {
    final savedDifficulty = await _settingsRepository.loadDifficulty();
    setState(() {
      _selectedGameDifficulty = savedDifficulty;
    });
  }

  void _saveSelectedDifficulty(int index) {
    setState(() {
      for (int i = 0; i < _selectedDifficulty.length; i++) {
        _selectedDifficulty[i] = i == index;
      }
    });

    // Salva a dificuldade selecionada
    _settingsRepository.saveDifficulty(GameDifficulty.values[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configrações'), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Selecione o Nível de Dificuldade',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ToggleButtons(
                  direction: Axis.vertical,
                  onPressed: (int index) {
                    setState(() {
                      _selectedGameDifficulty = GameDifficulty.values[index];
                    });

                    _saveSelectedDifficulty(index);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.red[700],
                  selectedColor: Colors.black,
                  fillColor: Colors.red[200],
                  color: Colors.black,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 90.0,
                  ),
                  isSelected: _selectedDifficulty,
                  children: GameDifficulty.values
                      .map(
                        (difficulty) => Text(switch (difficulty) {
                          GameDifficulty.medium => 'Médio',
                          GameDifficulty.hard => 'Difícil',
                          GameDifficulty.easy => 'Fácil',
                        }),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
