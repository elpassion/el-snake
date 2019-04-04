import 'dart:math';
import 'dart:ui';

import 'package:el_snake/snake-game.dart';
import 'package:flutter/material.dart';

class Snake {
  final SnakeGame game;
  List<Point<double>> points;
  Point<double> velocity;
  Paint paint = Paint();
  var length = 400;

  Snake(this.game, double x, double y) {
    points = [Point(x, y)];
    velocity = Point(0, 0);
    paint.color = Color(0xffff0000);
  }

  void render(Canvas canvas) {
    for (var i = 0; i < points.length - 1; i++) {
      var hue = (points[i].distanceTo(points[points.length - 1]) * 10) % 360;
      paint.color = HSLColor.fromAHSL(1.0, hue, 0.5, 0.5).toColor();
      canvas.drawCircle(Offset(points[i].x, points[i].y), 16, paint);
    }
  }

  void update(double t) {
    var head = points.last;
    var newHead = Point(head.x + velocity.x * t, head.y + velocity.y * t);

    points.add(newHead);
    updateTail();
  }

  void updateTail() {
    var tailLength = 0.0;
    var lastIndex = 0;
    for (var i = points.length - 1; i > 0; i--) {
      var distance = points[i].distanceTo(points[i - 1]);
      tailLength += distance;
      if (tailLength > length) {
        lastIndex = i;
        break;
      }
    }
    points = points.sublist(lastIndex, points.length);
  }
}
