import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Map for initial chess piece positions
    var initialPositions = {
      'a1': 'images/Chess_rlt45.png', 'b1': 'images/Chess_nlt45.png', 'c1': 'images/Chess_blt45.png',
      'd1': 'images/Chess_qlt45.png', 'e1': 'images/Chess_klt45.png', 'f1': 'images/Chess_blt45.png',
      'g1': 'images/Chess_nlt45.png', 'h1': 'images/Chess_rlt45.png',
      'a2': 'images/Chess_plt45.png', 'b2': 'images/Chess_plt45.png', 'c2': 'images/Chess_plt45.png',
      'd2': 'images/Chess_plt45.png', 'e2': 'images/Chess_plt45.png', 'f2': 'images/Chess_plt45.png',
      'g2': 'images/Chess_plt45.png', 'h2': 'images/Chess_plt45.png',
      'a7': 'images/Chess_pdt45.png', 'b7': 'images/Chess_pdt45.png', 'c7': 'images/Chess_pdt45.png',
      'd7': 'images/Chess_pdt45.png', 'e7': 'images/Chess_pdt45.png', 'f7': 'images/Chess_pdt45.png',
      'g7': 'images/Chess_pdt45.png', 'h7': 'images/Chess_pdt45.png',
      'a8': 'images/Chess_rdt45.png', 'b8': 'images/Chess_ndt45.png', 'c8': 'images/Chess_bdt45.png',
      'd8': 'images/Chess_qdt45.png', 'e8': 'images/Chess_kdt45.png', 'f8': 'images/Chess_bdt45.png',
      'g8': 'images/Chess_ndt45.png', 'h8': 'images/Chess_rdt45.png',
    };

    var numberstoletters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chess Board'),
        ),
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8, 
                crossAxisSpacing: 0, 
                mainAxisSpacing: 0,
              ),
              itemCount: 64, 
              itemBuilder: (context, index) {
                var x = index % 8;
                var letter = numberstoletters[x];
                var y = 8 - (index ~/ 8); 
                String position = '$letter$y';

                
                bool isEvenRow = (index ~/ 8) % 2 == 0;
                bool isEvenTile = index % 2 == 0;
                Color tileColor;

                if (isEvenRow) {
                  tileColor = isEvenTile ? const Color.fromARGB(255, 238, 238, 210) : const Color.fromARGB(255, 118, 150, 86);
                } else {
                  tileColor = isEvenTile ? const Color.fromARGB(255, 118, 150, 86) : const Color.fromARGB(255, 238, 238, 210);
                }

                return Container(
                  color: tileColor,
                  child: Center(
                    
                    child: initialPositions.containsKey(position)
                      ? TextButton(
                        onPressed: () {
                          _function(position);
                        }, 
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Image.asset(
                            initialPositions[position]!,
                            width: 40,
                            height: 40,
                          ),
                        )
                        : Container(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


void _function(position) {
  print(position);
}
}

// Convert map tyo piece to  image
// list of pieces and their positions
// function takes piece and position, can use this to calculate possible moves
  // list of highlighted tiles
  // store current piece as selected
// new fn
  // if empty tile highlighted and clicked
    // move selected piece to that tile