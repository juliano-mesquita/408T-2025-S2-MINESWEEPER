import 'package:flutter/material.dart';

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

class TabuleiroPage extends StatelessWidget {
const TabuleiroPage({super.key});

final int linhas = 8;
final int colunas = 8;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Tabuleiro Responsivo'),
centerTitle: true,
),
body: Column(
children: [
Expanded(
child: LayoutBuilder(
builder: (context, constraints) {
final double cellSize = constraints.maxWidth / colunas * linhas;

return GridView.builder(
padding: EdgeInsets.zero,
physics: const NeverScrollableScrollPhysics(),
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: colunas,
childAspectRatio: 1.0,
),
itemCount: linhas * colunas,
itemBuilder: (context, index) {
final int linha = index ~/ colunas;
final int coluna = index % colunas;

return GestureDetector(
onTap: () {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Clicou em [$linha, $coluna]'),
duration: const Duration(milliseconds: 600),
),
);
},
child: Container(
width: cellSize,
height: cellSize * double.infinity,
decoration: BoxDecoration(
color: Colors.blue[300],
border: Border.all(color: Colors.white, width: 1.5),
),
child: Center(
child: Text(
'$linha,$coluna',
style: const TextStyle(
fontWeight: FontWeight.bold,
color: Colors.black87,
),
),
),
),
);
},
);
},
),
),
],
),
);
}
}

