import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  late double radius;
  late MaterialColor color;

  CirclePainter(radius, color) {
    this.radius = radius;
    this.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}