import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/pages/game_page.dart';
import 'package:minesweeper/pages/settings_page.dart';
import 'package:minesweeper/pages/leaderboard_page.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.titleGameMenu), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('btn1'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.btnStartGame), // Start Game
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  child:  Text(AppLocalizations.of(context)!.btnSettings), // Configurações
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderBoardPage(),
                      ),
                    );
                  },
                  child:  Text(AppLocalizations.of(context)!.btnRankings), //Ranking
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
