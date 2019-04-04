import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class World {
  final radius = 500.0;
  final stroke = 16.0;

  Point<double> get center => Point(0, 0);

  void render(Canvas canvas) {
    Paint bgPaint = Paint();
    bgPaint.color = HSLColor.fromAHSL(1.0, 269, 1.0, 0.3).toColor();
    bgPaint.style = PaintingStyle.stroke;
    bgPaint.strokeWidth = stroke;

    canvas.drawCircle(Offset(0, 0), radius, bgPaint);
  }

  void update(double t) {}
}
