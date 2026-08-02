import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double y;

  const Bird({
    super.key,
    required this.y,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 16),
      alignment: Alignment(-0.4, y),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 42,
        ),
      ),
    );
  }
}
