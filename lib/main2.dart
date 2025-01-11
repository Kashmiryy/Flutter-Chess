import 'package:flutter/material.dart';
// import 'package:stockfish/stockfish.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var piecePositions = {
  
    'white_rook_1': 'a1', 'white_knight_1': 'b1', 'white_bishop_1': 'c1',
    'white_queen': 'd1', 'white_king': 'e1', 'white_bishop_2': 'f1',
    'white_knight_2': 'g1', 'white_rook_2': 'h1',
    'white_pawn_1': 'a2', 'white_pawn_2': 'b2', 'white_pawn_3': 'c2',
    'white_pawn_4': 'd2', 'white_pawn_5': 'e2', 'white_pawn_6': 'f2',
    'white_pawn_7': 'g2', 'white_pawn_8': 'h2',

    'black_rook_1': 'a8', 'black_knight_1': 'b8', 'black_bishop_1': 'c8',
    'black_queen': 'd8', 'black_king': 'e8', 'black_bishop_2': 'f8',
    'black_knight_2': 'g8', 'black_rook_2': 'h8',
    'black_pawn_1': 'a7', 'black_pawn_2': 'b7', 'black_pawn_3': 'c7',
    'black_pawn_4': 'd7', 'black_pawn_5': 'e7', 'black_pawn_6': 'f7',
    'black_pawn_7': 'g7', 'black_pawn_8': 'h7',
  };

  var pieceImages = {
    'white_rook_1': 'images/Chess_rlt45.png', 'white_knight_1': 'images/Chess_nlt45.png',
    'white_bishop_1': 'images/Chess_blt45.png', 'white_queen': 'images/Chess_qlt45.png',
    'white_king': 'images/Chess_klt45.png', 'white_bishop_2': 'images/Chess_blt45.png',
    'white_knight_2': 'images/Chess_nlt45.png', 'white_rook_2': 'images/Chess_rlt45.png',
    'white_pawn_1': 'images/Chess_plt45.png', 'white_pawn_2': 'images/Chess_plt45.png',
    'white_pawn_3': 'images/Chess_plt45.png', 'white_pawn_4': 'images/Chess_plt45.png',
    'white_pawn_5': 'images/Chess_plt45.png', 'white_pawn_6': 'images/Chess_plt45.png',
    'white_pawn_7': 'images/Chess_plt45.png', 'white_pawn_8': 'images/Chess_plt45.png',

    'black_rook_1': 'images/Chess_rdt45.png', 'black_knight_1': 'images/Chess_ndt45.png',
    'black_bishop_1': 'images/Chess_bdt45.png', 'black_queen': 'images/Chess_qdt45.png',
    'black_king': 'images/Chess_kdt45.png', 'black_bishop_2': 'images/Chess_bdt45.png',
    'black_knight_2': 'images/Chess_ndt45.png', 'black_rook_2': 'images/Chess_rdt45.png',
    'black_pawn_1': 'images/Chess_pdt45.png', 'black_pawn_2': 'images/Chess_pdt45.png',
    'black_pawn_3': 'images/Chess_pdt45.png', 'black_pawn_4': 'images/Chess_pdt45.png',
    'black_pawn_5': 'images/Chess_pdt45.png', 'black_pawn_6': 'images/Chess_pdt45.png',
    'black_pawn_7': 'images/Chess_pdt45.png', 'black_pawn_8': 'images/Chess_pdt45.png',
  };

  String? selectedPiece; 
  var numberstoletters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
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
                Color tileColor = isEvenRow
                    ? (isEvenTile
                        ? const Color.fromARGB(255, 238, 238, 210)
                        : const Color.fromARGB(255, 118, 150, 86))
                    : (isEvenTile
                        ? const Color.fromARGB(255, 118, 150, 86)
                        : const Color.fromARGB(255, 238, 238, 210));

                // Check if piece at current position
                String? pieceAtPosition;
                for (var entry in piecePositions.entries) {
                  if (entry.value == position) {
                    pieceAtPosition = entry.key;
                    break;
                  }
                }

                return GestureDetector(
                  onTap: () {
                    _handleTap(position, pieceAtPosition);
                  },
                  child: Container(
                    color: tileColor,
                    child: Center(
                      child: pieceAtPosition != null
                          ? Image.asset(
                              pieceImages[pieceAtPosition]!,
                              width: 40,
                              height: 40,
                            )
                          : Container(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  
  void _handleTap(String position, String? pieceAtPosition) {
    print(position);
    print(pieceAtPosition);
    setState(() {
      if (selectedPiece == null && pieceAtPosition != null) {
        selectedPiece = pieceAtPosition;
      } else if (selectedPiece != null) {
        piecePositions[selectedPiece!] = position;
        selectedPiece = null;
        
      }
    });
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