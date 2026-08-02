import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/bird.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Timer? gameTimer;

  double birdY = 0.0;
  double velocity = 0.0;

  bool gameStarted = false;
  bool gameOver = false;

  int score = 0;

  final double gravity = 0.0025;
  final double jumpPower = -0.035;

  double pipeX = 1.2;
  double topPipeHeight = 220;
  double bottomPipeHeight = 220;

  final Random random = Random();

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    gameTimer?.cancel();

    setState(() {
      birdY = 0.0;
      velocity = 0.0;
      pipeX = 1.2;
      score = 0;
      gameStarted = true;
      gameOver = false;
    });

    gameTimer = Timer.periodic(
      const Duration(milliseconds: 16),
      (timer) {
        if (!mounted || gameOver) {
          timer.cancel();
          return;
        }

        updateGame();
      },
    );
  }

  void jump() {
    if (gameOver) {
      startGame();
      return;
    }

    if (!gameStarted) {
      startGame();
    }

    setState(() {
      velocity = jumpPower;
    });
  }

  void updateGame() {
    setState(() {
      velocity += gravity;
      birdY += velocity;

      pipeX -= 0.012;

      if (pipeX < -1.4) {
        pipeX = 1.2;
        score++;

        topPipeHeight = 140 + random.nextDouble() * 170;
        bottomPipeHeight = 140 + random.nextDouble() * 170;
      }

      if (birdY > 0.88 || birdY < -1.0) {
        finishGame();
      }
    });
  }

  void finishGame() {
    gameTimer?.cancel();

    setState(() {
      gameOver = true;
      gameStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: jump,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5EC8FF),
                    Color(0xFFBCEFFF),
                  ],
                ),
              ),
            ),

            Bird(
              left: screenWidth * 0.30,
              top: screenHeight * (birdY + 1) / 2,
            ),

            Positioned(
              top: 0,
              left: screenWidth * pipeX,
              child: Container(
                width: 70,
                height: topPipeHeight,
                color: Colors.green,
              ),
            ),

            Positioned(
              bottom: 70,
              left: screenWidth * pipeX,
              child: Container(
                width: 70,
                height: bottomPipeHeight,
                color: Colors.green,
              ),
            ),

            Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: Text(
                '$score',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
              ),
            ),

            if (!gameStarted && !gameOver)
              const Center(
                child: Text(
                  'Başlamak için dokun',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

            if (gameOver)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Oyun Bitti',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Puan: $score',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Tekrar başlamak için dokun',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 70,
              child: ColoredBox(
                color: Color(0xFF78C850),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
