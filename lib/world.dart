import 'dart:ui';

import 'package:flutter/cupertino.dart';

class World {
  void render(Canvas canvas) {
    Paint bgPaint = Paint();
    bgPaint.color = HSLColor.fromAHSL(1.0, 269, 1.0, 0.3).toColor();
    bgPaint.style = PaintingStyle.stroke;
    bgPaint.strokeWidth = 16;

    canvas.drawCircle(Offset(0, 0), 500, bgPaint);
  }

  void update(double t) {}
}
