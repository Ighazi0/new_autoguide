import 'dart:math';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class VerifiedStarIcon extends StatelessWidget {
  final double size;
  final Color starColor;

  const VerifiedStarIcon({
    super.key,
    required this.size,
    this.starColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SevenPointedStar(size: size, color: starColor),
        Icon(Bootstrap.check, color: Colors.white, size: size * 0.75),
      ],
    );
  }
}

class SevenPointedStar extends StatelessWidget {
  final double size;
  final Color color;

  const SevenPointedStar({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _StarPainter(color));
  }
}

class _StarPainter extends CustomPainter {
  final Color color;

  _StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius / 1.8;
    final int numPoints = 7;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    for (int i = 0; i < numPoints * 2; i++) {
      final bool isEven = i % 2 == 0;
      final double radius = isEven ? outerRadius : innerRadius;
      final double angle = (pi / numPoints) * i - pi / 2;

      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
