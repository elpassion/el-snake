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

  bool collidesWith(Point<double> otherCenter, double otherRadius) {
    var margin = 0.0;
    if (stroke.deadly) {
      margin = stroke.thickness / 2;
    }
    if (stroke.deadly || fill.deadly) {
      var centersDistance = center.distanceTo(otherCenter);
      var outCirclesDistance = centersDistance - radius - otherRadius - margin;
      if (outCirclesDistance <= 0) {
        return true;
      } else {
        var inCirclesDistance = radius - centersDistance - otherRadius - margin;
        return inCirclesDistance <= 0;
      }
    }
    return false;
  }
}

class Material {
  final double alpha; // 0..1
  final double hue; // 0..360
  final double saturation; // 0..1
  final double lightness; // 0.1
  final bool deadly;
  final double thickness;

  Material(this.alpha, this.hue, this.saturation, this.lightness, this.deadly,
      this.thickness);

  Color get color =>
      HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor();
}
