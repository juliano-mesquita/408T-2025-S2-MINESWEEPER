
import 'package:flutter/material.dart';

class TabuleiroPage extends StatelessWidget {
  const TabuleiroPage({super.key});

  final double cellSize = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabuleiro Células Fixas"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double bottomPadding = 10;

          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight - bottomPadding;

          int colunas = (availableWidth / cellSize).floor();
          int linhas = (availableHeight / cellSize).floor();

          int totalCelas = linhas * colunas;

          return Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colunas,
                childAspectRatio: 1.0,
              ),
              itemCount: totalCelas,
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
