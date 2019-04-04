import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class World {
  final Point<double> center;
  final double radius;
  final stroke = 16.0;

  World(this.center, this.radius);

  void render(Canvas canvas) {
    Paint bgPaint = Paint();
    bgPaint.color = HSLColor.fromAHSL(1.0, 269, 1.0, 0.3).toColor();
    bgPaint.style = PaintingStyle.stroke;
    bgPaint.strokeWidth = stroke;

    canvas.drawCircle(Offset(center.x, center.y), radius, bgPaint);
  }

  void update(double t) {}
}
