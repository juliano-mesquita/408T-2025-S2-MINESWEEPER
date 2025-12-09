import 'package:flutter/material.dart';
import 'package:minesweeper/controller/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsController _settingsController =
      SettingsController(); // Instância do controlador
  final List<bool> _selectedDifficulty = <bool>[true, false, false];

  @override
  void initState() {
    super.initState();
    _loadSelectedDifficulty();
  }

  Future<void> _loadSelectedDifficulty() async {
    final savedDifficulty = await _settingsController.loadSelectedDifficulty();
    setState(() {
      for (int i = 0; i < _settingsController.difficulties.length; i++) {
        _selectedDifficulty[i] =
            _settingsController.difficulties[i] == savedDifficulty;
      }
    });
  }

  void _onDifficultySelected(int index) {
    setState(() {
      for (int i = 0; i < _selectedDifficulty.length; i++) {
        _selectedDifficulty[i] = i == index;
      }
    });

    // Salva a dificuldade selecionada
    _settingsController.saveSelectedDifficulty(
      _settingsController.difficulties[index],
    );
  }

  bool vertical = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Selecione o Nível de Dificuldade',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.vertical,
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
                onPressed: _onDifficultySelected,
                children: _settingsController.difficulties
                    .map((e) => Text(e))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
