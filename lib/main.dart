import 'package:flutter/material.dart';

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
  List<String> possibleMoves = [];
  var numberstoletters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  String currentplayer = "white";
  String? lastpiecemoved;
  String? piecetoremove;
  String? enpassantposition;
  bool whiteKingMoved = false;
  bool blackKingMoved = false;
  bool whiteRook1Moved = false;
  bool whiteRook2Moved = false;
  bool blackRook1Moved = false;
  bool blackRook2Moved = false;
  bool castlingPossible = false;

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
              physics: NeverScrollableScrollPhysics(),
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

                // Highlight possible moves
                if (possibleMoves.contains(position)) {
                  tileColor = Colors.yellowAccent;
                }

                // Check if a piece is at the current position
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
    setState(() {
      //Detect if the king is in check at the start of a turn.
      //Generate all valid moves for the current player.
      //Restrict the player to choose only from valid moves.
      //Validate each move by simulating and ensuring the king is not in check.

      if (isKingInCheck(currentplayer, piecePositions)) {
        

      }
      if (selectedPiece == null && pieceAtPosition != null && pieceAtPosition.contains(currentplayer)) {
        // Select the piece and calculate possible moves
        selectedPiece = pieceAtPosition;
        possibleMoves = getPossibleMoves(pieceAtPosition, position, piecePositions);
  
      } else if (selectedPiece != null && possibleMoves.contains(position)) {
        // Move the selected piece if the tapped position is a valid move
        piecePositions.remove(pieceAtPosition);
        if (position == enpassantposition){
          piecePositions.remove(lastpiecemoved);
        }
        // Castling castle movement logic
        if (selectedPiece!.contains('king') && position=='g1' && castlingPossible) {
          piecePositions['white_rook_2'] = 'f1';
          whiteRook2Moved = true;
        }
        if (selectedPiece!.contains('king') && position=='c1' && castlingPossible) {
          piecePositions['white_rook_1'] = 'd1';
          whiteRook1Moved = true;
        }
        if (selectedPiece!.contains('king') && position=='g8' && castlingPossible) {
          piecePositions['black_rook_2'] = 'f8';
          blackRook2Moved = true;
        }
        if (selectedPiece!.contains('king') && position=='c8' && castlingPossible) {
          piecePositions['black_rook_1'] = 'd8';
          blackRook1Moved = true;
        }

        if (selectedPiece!.contains('king')) {
          if (selectedPiece!.contains('white')) {
            whiteKingMoved = true;
          }
          else {
            blackKingMoved = true;
          }
        }

        if (selectedPiece!.contains('rook')) {
          if (selectedPiece!.contains('white')) {
            if (selectedPiece!.contains('1')) {
              whiteRook1Moved = true;
            }
            else{
              whiteRook2Moved = true;
            }
          }
          else {
            if (selectedPiece!.contains('1')) {
              blackRook1Moved = true;
            }
            else{
              blackRook2Moved = true;
            }
          }
        }


        piecePositions[selectedPiece!] = position;
        lastpiecemoved = selectedPiece;
        selectedPiece = null; // Deselect the piece
        possibleMoves.clear(); // Clear possible moves after move
        currentplayer = currentplayer == 'white' ? 'black' : 'white';
      } else {
        // Deselect the piece if tapping elsewhere
        selectedPiece = null;
        possibleMoves.clear();
      }
    });
  }

 List<String> getPossibleMoves(String piece, String position, Map<String, String> piecePositions, {bool checkForCheck=false}) {
  List<String> moves = [];
  String col = position[0];
  int row = int.parse(position[1]);

  // Helper functions
  // Helper function to check if the path is clear between two squares
  bool isPathClear(String start, String end, Map<String, String> piecePositions) {
    
    
    int startCol = start.codeUnitAt(0);
    int startRow = int.parse(start[1]);
    int endCol = end.codeUnitAt(0);

    int direction = startCol < endCol ? 1 : -1;
    for (int col = startCol + direction; col != endCol; col += direction) {
      String position = String.fromCharCode(col) + startRow.toString();
      if (piecePositions.containsValue(position)) return false;
    }

    return true;
  }
  bool isKingInCheck(String currentPlayer, Map<String, String> piecePositions) {
    // Determine king's position
    String? kingPosition = piecePositions['${currentPlayer}_king'];
    if (kingPosition == null) return false; // King's position is not found

    // Identify opponent color
    String opponentColor = currentPlayer == 'white' ? 'black' : 'white';

    // Check if any opponent piece's possible moves threaten the king
    for (var entry in piecePositions.entries) {
      String piece = entry.key;
      String position = entry.value;

      if (piece.startsWith(opponentColor)) {
        List<String> opponentMoves = getPossibleMoves(piece, position, piecePositions, checkForCheck:true);
        print(opponentMoves);

        // If any opponent's move can target the king's position, the king is in check
        if (opponentMoves.contains(kingPosition)) {
          print('king in check');
          return true;
        }
      }
    }

    return false; // King is not in check
  }
// Helper function to check if the king would be in check at any position in the list
  bool isKingInCheckAtPositions(String currentPlayer, List<String> positions) {
    for (String position in positions) {
      // Temporarily set king's position to the test position
      String tempPos = piecePositions['${currentPlayer}_king']!;
      piecePositions['${currentPlayer}_king'] = position;

      if (isKingInCheck(currentPlayer, piecePositions)) {
        piecePositions['${currentPlayer}_king'] = tempPos;
        return true; // King would be in check in one of these positions
      }
      piecePositions['${currentPlayer}_king'] = tempPos;
    }
    
    return false;
  }
  bool isWithinBounds(String pos) {
    return pos.length == 2 && pos[0].compareTo('a') >= 0 && pos[0].compareTo('h') <= 0 && int.parse(pos[1]) >= 1 && int.parse(pos[1]) <= 8;
  }

  bool isEmpty(String pos) {
    return !piecePositions.containsValue(pos);
  }

  bool isOpponentPiece(String pos, String currentPiece) {
    for (var entry in piecePositions.entries) {
      if (entry.value == pos && entry.key.startsWith(currentPiece.startsWith('white') ? 'black' : 'white')) {
        return true;
      }
    }
    return false;
  }

// Castling function
List<String> getCastlingMoves(String currentPlayer) {
  List<String> castlingMoves = [];

  if (currentPlayer == 'white') {
    // Conditions for white king-side castling
    if (!whiteKingMoved && !whiteRook2Moved) {
      if (isPathClear('e1', 'h1', piecePositions) &&
          !isKingInCheck('white', piecePositions) &&
          !isKingInCheckAtPositions('white', ['f1', 'g1'])) {
        castlingMoves.add('g1');
      }
    }
    // Conditions for white queen-side castling
    if (!whiteKingMoved && !whiteRook1Moved) {
      if (isPathClear('e1', 'a1', piecePositions) &&
          !isKingInCheck('white', piecePositions) &&
          !isKingInCheckAtPositions('white', ['d1', 'c1', 'b1'])) {
        castlingMoves.add('c1');
      }
    }
  } else {
    // Conditions for black king-side castling
    if (!blackKingMoved && !blackRook2Moved) {
      if (isPathClear('e8', 'h8', piecePositions) &&
          !isKingInCheck('black', piecePositions) &&
          !isKingInCheckAtPositions('black', ['f8', 'g8'])) {
        castlingMoves.add('g8');
      }
    }
    // Conditions for black queen-side castling
    if (!blackKingMoved && !blackRook1Moved) {
      if (isPathClear('e8', 'a8', piecePositions) &&
          !isKingInCheck('black', piecePositions) &&
          !isKingInCheckAtPositions('black', ['d8', 'c8', 'b8'])) {
        castlingMoves.add('c8');
      }
    }
  }

  return castlingMoves;
}

  // Helper function for straight line moves (Rook/Queen)
  void addLineMoves(int colStep, int rowStep) {
    for (int i = 1; i < 8; i++) {
      String nextCol = String.fromCharCode(col.codeUnitAt(0) + colStep * i);
      String nextRow = (row + rowStep * i).toString();
      String nextPos = nextCol + nextRow;

      if (!isWithinBounds(nextPos)) break;

      if (isEmpty(nextPos)) {
        moves.add(nextPos);
      } else if (isOpponentPiece(nextPos, piece)) {
        moves.add(nextPos);
        break;
      } else {
        break;  // Blocked by own piece
      }
    }
  }

  // Helper function for diagonal moves (Bishop/Queen)
  void addDiagonalMoves() {
    addLineMoves(1, 1);  // Diagonal up-right
    addLineMoves(-1, 1);  // Diagonal up-left
    addLineMoves(1, -1);  // Diagonal down-right
    addLineMoves(-1, -1);  // Diagonal down-left
  }

  bool isenpassant(String pos, String currentPiece, int direction){
    if (lastpiecemoved == null){
      return false;
    }
    var takingpieceposition = piecePositions[lastpiecemoved]!;
    var takingpiecepositioncolumn = takingpieceposition[0];
    int takingpiecepositionrow = int.parse(takingpieceposition[1]) + direction;

    if (lastpiecemoved!.contains('pawn') && pos==(takingpiecepositioncolumn+takingpiecepositionrow.toString())){
        enpassantposition = pos;
        return true;
    }
    return false;
  }


  // Pawn logic (unchanged)
  if (piece.contains('pawn')) {
    int direction = piece.startsWith('white') ? 1 : -1;
    String forward = col + (row + direction).toString();
    if (isEmpty(forward)) moves.add(forward);

    if ((row == 2 && piece.startsWith('white')) || (row == 7 && piece.startsWith('black'))) {
      String doubleMove = col + (row + 2 * direction).toString();
      if (isEmpty(forward) && isEmpty(doubleMove)) moves.add(doubleMove);
    }

    String diagLeft = String.fromCharCode(col.codeUnitAt(0) - 1) + (row + direction).toString();
    String diagRight = String.fromCharCode(col.codeUnitAt(0) + 1) + (row + direction).toString();
    if (isWithinBounds(diagLeft) && (isOpponentPiece(diagLeft, piece) || isenpassant(diagLeft, piece, direction))) moves.add(diagLeft);
    if (isWithinBounds(diagRight) && (isOpponentPiece(diagRight, piece)|| isenpassant(diagRight, piece, direction))) moves.add(diagRight);
  }

  // Rook logic (straight line moves)
  if (piece.contains('rook')) {
    addLineMoves(1, 0);  // Right
    addLineMoves(-1, 0);  // Left
    addLineMoves(0, 1);  // Up
    addLineMoves(0, -1);  // Down
  }

  // Bishop logic (diagonal moves)
  if (piece.contains('bishop')) {
    addDiagonalMoves();
  }

  // Knight logic (L-shaped moves)
  if (piece.contains('knight')) {
    List<String> knightMoves = [
      String.fromCharCode(col.codeUnitAt(0) + 2) + (row + 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) + 2) + (row - 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 2) + (row + 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 2) + (row - 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) + 1) + (row + 2).toString(),
      String.fromCharCode(col.codeUnitAt(0) + 1) + (row - 2).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 1) + (row + 2).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 1) + (row - 2).toString(),
    ];

    for (var move in knightMoves) {
      if (isWithinBounds(move) && (isEmpty(move) || isOpponentPiece(move, piece))) {
        moves.add(move);
      }
    }
  }

  // Queen logic (combines rook and bishop)
  if (piece.contains('queen')) {
    addLineMoves(1, 0);  // Right
    addLineMoves(-1, 0);  // Left
    addLineMoves(0, 1);  // Up
    addLineMoves(0, -1);  // Down
    addDiagonalMoves();  // Diagonal moves
  }

  // King logic (moves one square in any direction)
  if (piece.contains('king')) {
    List<String> kingMoves = [
      String.fromCharCode(col.codeUnitAt(0) + 1) + row.toString(),
      String.fromCharCode(col.codeUnitAt(0) - 1) + row.toString(),
      col + (row + 1).toString(),
      col + (row - 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) + 1) + (row + 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 1) + (row + 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) + 1) + (row - 1).toString(),
      String.fromCharCode(col.codeUnitAt(0) - 1) + (row - 1).toString(),
    ];
    if (!checkForCheck){
      var castlingMoves = getCastlingMoves(currentplayer);
      if (castlingMoves.isNotEmpty) {
        castlingPossible = true;
      }
      kingMoves.addAll(castlingMoves);
    }
  
 
    for (var move in kingMoves) {
      if (isWithinBounds(move) && (isEmpty(move) || isOpponentPiece(move, piece))) moves.add(move);
    }
  }

  return moves;
}



}

// returns 
  // castling
    // check if empty between king and rook
    // if is make block available for king
    // castleingposition variable
    // if king does move, move rook to position next to it in handle tap
    
  // check
// mate
  

// Castling can take place even when king or rook have been moved already
// King can move to castle position from anywhere on the board 
// Castling does get blocked when king in check (good)
// Now need a way to calculate check