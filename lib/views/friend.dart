import 'package:flutter/material.dart';

class FriendView extends StatefulWidget {
  const FriendView({super.key});

  @override
  State<FriendView> createState() => _FriendViewState();
}

class _FriendViewState extends State<FriendView> {
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
      board = ['', '', '', '', '', '', '', '', ''];
      player = true;
      playerTurn = 'X';
      gameover = false;
    });
  }

  void play(int index) {
    setState(() {
      if (board[index] == '') {
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

  void _onTap(int index) async {
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
    }
  }

  Future<void> showDialogMessage(
      BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
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
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: gameover ? null : () => _onTap(index),
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
          )
        ],
      ),
    );
  }
}
