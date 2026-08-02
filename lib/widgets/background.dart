import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF5EC8FF),
            Color(0xFFB8F1FF),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: 90,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
