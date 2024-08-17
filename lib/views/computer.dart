import 'package:flutter/material.dart';

class ComputerView extends StatefulWidget {
  const ComputerView({super.key});

  @override
  State<ComputerView> createState() => _ComputerViewState();
}

class _ComputerViewState extends State<ComputerView> {
  late List<String> board;
  late String playerTurn;
  late bool player, gameover;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      board = List.filled(9, '');
      player = true; // Player X starts
      playerTurn = 'X';
      gameover = false;
    });
  }

  void play(int index) {
    setState(() {
      if (board[index] == '' && !gameover) {
        board[index] = playerTurn;
        player = !player;
        playerTurn = player ? 'X' : 'O';
      }
    });
  }

  String checkWinner() {
    List<List<int>> winIndices = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var indices in winIndices) {
      String a = board[indices[0]];
      String b = board[indices[1]];
      String c = board[indices[2]];
      if (a == b && b == c && a != '') {
        return a;
      }
    }

    if (!board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  List<int> findEmptyFields(List<String> board) {
    List<int> emptyFields = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyFields.add(i);
      }
    }
    return emptyFields;
  }

  int minMax(List<String> board, bool isMaximizing) {
    String result = checkWinner();
    if (result != '') {
      if (result == 'X') return -10;
      if (result == 'O') return 10;
      return 0;
    }

    List<int> emptyFields = findEmptyFields(board);

    if (isMaximizing) {
      int bestScore = -1000;
      int bestMove = -1;
      for (int index in emptyFields) {
        board[index] = 'O';
        int score = minMax(board, false);
        board[index] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = index;
        }
      }
      return bestMove;
    } else {
      int bestScore = 1000;
      int bestMove = -1;
      for (int index in emptyFields) {
        board[index] = 'X';
        int score = minMax(board, true);
        board[index] = '';
        if (score < bestScore) {
          bestScore = score;
          bestMove = index;
        }
      }
      return bestMove;
    }
  }

  void _onTap(int index) async {
    if (board[index] == '' && !gameover) {
      play(index);

      String winner = checkWinner();
      if (winner != '') {
        gameover = true;
        await showDialogMessage(
          context,
          winner == 'Draw' ? 'Draw' : 'Winner',
          winner == 'Draw' ? 'It\'s a Draw' : 'Player $winner Wins',
        );

        startGame();
        return;
      }

      if (!player) {
        _aiMove();
      }
    }
  }

  void _aiMove() {
    int bestMove = minMax(board, true); //
    if (bestMove != -1) {
      play(bestMove);
      String winner = checkWinner();
      if (winner != '') {
        gameover = true;
        showDialogMessage(
          context,
          winner == 'Draw' ? 'Draw' : 'Winner',
          winner == 'Draw' ? 'It\'s a Draw' : 'Player $winner Wins',
        );
      }
    }
  }

  Future<void> showDialogMessage(
      BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          content: Text(message, style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
                setState(() {});
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Player Turn: $playerTurn',
            style: const TextStyle(fontSize: 40.0, color: Colors.white),
          ),
          const SizedBox(height: 30),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                // shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _onTap(index),
                    child: Container(
                      color: const Color.fromARGB(255, 0, 5, 94),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(
                            fontSize: 60.0,
                            color: board[index] == 'X'
                                ? const Color.fromARGB(255, 90, 9, 240)
                                : const Color.fromARGB(255, 238, 30, 30),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                startGame();
              });
            },
            label: const Text(
              "Reset",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            icon: const Icon(
              Icons.replay,
              size: 30,
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(290, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
              iconColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 216, 54, 13),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
