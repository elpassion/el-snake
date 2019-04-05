import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Circle {
  final Point<double> center;
  final double radius;
  final Material fill;
  final Material stroke;

  Paint fillPaint;
  Paint strokePaint;

  Circle(this.center, this.radius, this.fill, this.stroke) {
    if (fill != null) {
      fillPaint = Paint()..color = fill.color;
    }
    if (stroke != null) {
      strokePaint = Paint()..color = stroke.color;
    }
  }

  void render(Canvas canvas) {
    if (fillPaint != null) {
      canvas.drawCircle(Offset(center.x, center.y), radius, fillPaint);
    }
    if (strokePaint != null) {
      canvas.drawCircle(Offset(center.x, center.y), radius, strokePaint);
    }
  }
}

class Material {
  double alpha; // 0..1
  double hue; // 0..360
  double saturation; // 0..1
  double lightness; // 0.1
  bool deadly;

  Color get color =>
      HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor();
}
