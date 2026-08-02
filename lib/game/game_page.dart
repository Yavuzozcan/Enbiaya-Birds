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

  double pipeX = 1.15;
  double gapCenter = 0.0;

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
      pipeX = 1.15;
      gapCenter = 0.0;
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

      pipeX -= 0.018;

      if (pipeX < -0.35) {
        pipeX = 1.15;
        gapCenter = -0.45 + random.nextDouble() * 0.90;
        score++;
      }

      if (birdY > 0.82 || birdY < -0.95) {
        finishGame();
        return;
      }

      final birdLeft = 0.30;
      final birdRight = 0.30 + 0.22;

      final pipeLeft = pipeX;
      final pipeRight = pipeX + 0.18;

      final birdHitsPipeX =
          birdRight > pipeLeft && birdLeft < pipeRight;

      if (birdHitsPipeX) {
        const gapHalf = 0.28;

        final gapTop = gapCenter - gapHalf;
        final gapBottom = gapCenter + gapHalf;

        final birdTop = birdY - 0.11;
        final birdBottom = birdY + 0.11;

        final insideGap =
            birdTop > gapTop && birdBottom < gapBottom;

        if (!insideGap) {
          finishGame();
        }
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

    const pipeWidth = 74.0;
    const gapHeight = 220.0;

    final gapCenterPx =
        screenHeight * (gapCenter + 1) / 2;

    final topPipeHeight =
        (gapCenterPx - gapHeight / 2).clamp(
      40.0,
      screenHeight - 300.0,
    );

    final bottomPipeTop =
        gapCenterPx + gapHeight / 2;

    final bottomPipeHeight =
        (screenHeight - bottomPipeTop - 70).clamp(
      40.0,
      screenHeight - 300.0,
    );

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
              top: screenHeight * (birdY + 1) / 2 - 50,
              size: 100,
            ),

            Positioned(
              top: 0,
              left: screenWidth * pipeX,
              child: Container(
                width: pipeWidth,
                height: topPipeHeight,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.green.shade900,
                    width: 3,
                  ),
                ),
              ),
            ),

            Positioned(
              top: bottomPipeTop,
              left: screenWidth * pipeX,
              child: Container(
                width: pipeWidth,
                height: bottomPipeHeight,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.green.shade900,
                    width: 3,
                  ),
                ),
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
                  textAlign: TextAlign.center,
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
