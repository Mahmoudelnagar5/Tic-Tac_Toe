import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:x_o_game/views/home_view.dart';

void main() {
  runApp(DevicePreview(
    // enabled: true,
    builder: (context) => const TicTacToe(),
  ));
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
