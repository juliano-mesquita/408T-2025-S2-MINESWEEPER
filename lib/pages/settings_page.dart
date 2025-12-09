import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minesweeper/controller/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final List<bool> _selecteddificulty = <bool>[true, false, false];
  bool vertical = false;

  final Map<String, List<int>> boardSizes = {
    'Fácil 8x8': [8, 8],
    'Médio 10x10': [10, 10],
    'Difícil 12x12': [12, 12],
  };

  @override
  void initState() {
    super.initState();
    _loadSelectedDifficulty(); //carregar a dificuldade salva
  }

  Future<void> _loadSelectedDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDifficulty =
        prefs.getString('selectedDifficulty') ?? 'Fácil 8x8';

    setState(() {
      for (int i = 0; i < dificuldades.length; i++) {
        _selecteddificulty[i] = dificuldades[i] == savedDifficulty;
      }
    });
  }

  Future<void> _saveSelectedDifficulty(String difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedDifficulty', difficulty);
  }

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
                  direction: vertical ? Axis.vertical : Axis.vertical,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selecteddificulty.length; i++) {
                        _selecteddificulty[i] = i == index;
                      }
                    });

                    _saveSelectedDifficulty(dificuldades[index]);
                    final selectedBoardSize = boardSizes[dificuldades[index]];
                    print(
                      'Tamanho do tabuleiro: ${selectedBoardSize![0]}x${selectedBoardSize[1]}',
                    );
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
                  isSelected: _selecteddificulty,
                  children: dificuldades.map((e) => Text(e)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
