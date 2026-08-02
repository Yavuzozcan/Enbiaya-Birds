import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double left;
  final double top;
  final double size;

  const Bird({
    super.key,
    required this.left,
    required this.top,
    this.size = 68,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 16),
      curve: Curves.linear,
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
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
