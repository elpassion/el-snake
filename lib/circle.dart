import 'dart:math';
import 'dart:ui';

import 'package:el_snake/material.dart';
import 'package:flutter/cupertino.dart';

class Circle {
  final String snakeId;
  final Point<double> center;
  final double radius;
  final Material fill;
  final Material stroke;

  Paint fillPaint;
  Paint strokePaint;

  Circle(this.center, this.radius, this.fill, this.stroke, this.snakeId) {
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

  bool collidesWith(Circle other) {
    /*var margin = 0.0;
    if (stroke.deadly) {
      margin = stroke.thickness / 2;
    }*/
    if (fill.deadly) {
      var centersDistance = center.distanceTo(other.center);
      var outCirclesDistance = centersDistance - radius - other.radius;
      if (outCirclesDistance <= 0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
    /*if (stroke.deadly || fill.deadly) {
      var centersDistance = center.distanceTo(other.center);
      var outCirclesDistance = centersDistance - radius - other.radius - margin;
      if (outCirclesDistance <= 0) {
        return true;
      } else {
        var inCirclesDistance = radius - centersDistance - other.radius - margin;
        return inCirclesDistance <= 0;
      }
    }
    return false;*/
  }
}
