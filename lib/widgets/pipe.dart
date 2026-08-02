import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  final double left;
  final double height;
  final bool isTop;

  const Pipe({
    super.key,
    required this.left,
    required this.height,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      child: Container(
        width: 70,
        height: height,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            color: Colors.green.shade900,
            width: 3,
          ),
        ),
      ),
    );
  }
}
