import 'dart:math';
import 'dart:ui';

import 'package:el_snake/snake-game.dart';
import 'package:flutter/material.dart';

class Snake {
  final SnakeGame game;
  final radius = 16.0;
  final length = 400;

  List<Point<double>> points;
  Point<double> velocity;
  Paint headPaint = Paint();
  Paint tailPaint = Paint();
  bool isDead = false;

  Point<double> get head => points.last;

  Snake(this.game, double x, double y) {
    points = [Point(x, y)];
    velocity = Point(0, 0);
    headPaint.style = PaintingStyle.fill;
    tailPaint.style = PaintingStyle.stroke;
  }

  void render(Canvas canvas) {
    renderTail(canvas);
    renderHead(canvas);
  }

  void renderTail(Canvas canvas) {
    for (var i = 1; i < points.length - 1; i++) {
      var hue = points[i].distanceTo(head) % 360;
      tailPaint.color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.4).toColor();
      canvas.drawCircle(Offset(points[i].x, points[i].y), radius, tailPaint);
    }
  }

  void renderHead(Canvas canvas) {
    headPaint.color = HSLColor.fromAHSL(0.8, 0, 1.0, 0.4).toColor();
    canvas.drawCircle(Offset(head.x, head.y), radius, headPaint);
  }

  void update(double t) {
    if (!isDead) {
      var newHead = Point(head.x + velocity.x * t, head.y + velocity.y * t);
      points.add(newHead);
      updateTail();
    }
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
