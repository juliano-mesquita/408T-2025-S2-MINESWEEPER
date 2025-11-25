import 'package:flutter/material.dart';
import 'package:minesweeper/widget/cell_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabuleiro Responsivo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TabuleiroPage(),
    );
  }
}

class CellState {
  bool isRevealed;
  bool isFlagged;

  CellState({this.isRevealed = false, this.isFlagged = false});
}

class TabuleiroPage extends StatefulWidget {
  const TabuleiroPage({super.key});

  @override
  State<TabuleiroPage> createState() => _TabuleiroPageState();
}

class _TabuleiroPageState extends State<TabuleiroPage> {
  final double cellSize = 70;
  Map<int, CellState> cellStates = {};

  void toggleFlag(int index) {
    setState(() {
      if (cellStates[index] == null) {
        cellStates[index] = CellState();
      }
      
      if (!cellStates[index]!.isRevealed) {
        cellStates[index]!.isFlagged = !cellStates[index]!.isFlagged;
      }
    });
  }

  void revealCell(int index) {
    setState(() {
      if (cellStates[index] == null) {
        cellStates[index] = CellState();
      }
      
      if (!cellStates[index]!.isFlagged) {
        cellStates[index]!.isRevealed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabuleiro"),
        centerTitle: true,
      ),
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
                CellState state = cellStates[index] ?? CellState();

                return CellWidget(
                  revealCell: () => revealCell(index),
                  toggleFlag: () => toggleFlag(index),
                  cellSize: cellSize
                );
              },
            ),
          );
        },
      ),
    );
  }
}