import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:x_o_game/views/computer.dart';
import 'package:x_o_game/views/friend.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const Text(
                "Tic Tac Toe",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 238, 30, 30),
                      Color.fromARGB(255, 77, 11, 201),
                    ],
                  ),
                ),
                child: Lottie.asset("assets/Animation - 1723890629139.json"),
              ),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FriendView()),
                  );
                },
                label: const Text(
                  "Play Vs Player",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                icon: const Icon(
                  Icons.person,
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
                  backgroundColor: const Color.fromARGB(255, 92, 2, 226),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ComputerView()),
                  );
                },
                label: const Text(
                  "Play Vs Computer",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                icon: const Icon(
                  Icons.computer,
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
            ],
          ),
        ),
      ),
    );
  }
}
