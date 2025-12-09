import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/app_localizations.dart';
import 'package:minesweeper/pages/settings_page.dart';
import 'package:minesweeper/pages/leaderboard_page.dart';

class LeaderboardPageState extends StatelessWidget {
  const LeaderboardPageState({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleLeaderboardPageState),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.separated(
          itemCount: 10, // Example: Top 10 players
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Player ${index + 1}'),
              subtitle: Text('Time: ${100 - index * 5}'), // Example scores
            );
          },
        ),
      ),
    );
  }
}