import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

class Explosion {
  final Point<double> point;

  Paint paint = Paint();
  double radius = 1;

  Explosion(this.point) {
    paint.color = Color(0x55ff0000);
    paint.style = PaintingStyle.fill;
  }

  void render(Canvas canvas) {
    for (var i = 0; i < 20; i++) {
      canvas.drawCircle(Offset(point.x, point.y), radius - 30 * i, paint);
    }
  }

  void update(double t) {
    radius += t * 100;
  }
}
