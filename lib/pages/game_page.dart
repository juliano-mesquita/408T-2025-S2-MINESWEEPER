import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minesweeper/l10n/app_localizations.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final double cellSize = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text(AppLocalizations.of(context)!.titleBoard), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double bottomPadding = 10;

          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight - bottomPadding;

          int columns = (availableWidth / cellSize).floor();
          int lines = (availableHeight / cellSize).floor();

          int totalCells = lines * columns;

          return Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: 1.0,
              ),
              itemCount: totalCells,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
