import 'package:flutter/material.dart';

import 'game/game_page.dart';

void main() {
  runApp(const EnbiayaBirdsApp());
}

class EnbiayaBirdsApp extends StatelessWidget {
  const EnbiayaBirdsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enbiaya Birds',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}
