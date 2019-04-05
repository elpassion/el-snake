import 'dart:math';
import 'dart:ui';

import 'package:el_snake/circle.dart';
import 'package:el_snake/material.dart';
import 'package:el_snake/snake-game.dart';
import 'package:flutter/cupertino.dart';

class Snake {
  final SnakeGame game;
  final radius = 16.0;
  final length = 400;

  String id;
  List<Circle> circles;
  Point<double> velocity;
  Paint headPaint = Paint();
  Paint tailPaint = Paint();
  bool isDead = false;

  Circle get head => circles.last;

  Snake(id, this.game, Point<double> startPoint) {
    this.id = id;
    circles = [
      Circle(startPoint, radius, Material(1.0, 0.5, 0.5, 0.5, true, 0),
          Material(1.0, 0.5, 0.5, 0.5, true, 0), id)
    ];
    velocity = Point(0, 0);
    headPaint.style = PaintingStyle.fill;
    tailPaint.style = PaintingStyle.stroke;
  }

  void render(Canvas canvas) {
    renderTail(canvas);
    renderHead(canvas);
  }

  void renderTail(Canvas canvas) {
    for (var i = 1; i < circles.length - 1; i++) {
      var hue = circles[i].center.distanceTo(head.center) % 360;
      tailPaint.color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.4).toColor();
      canvas.drawCircle(
          Offset(circles[i].center.x, circles[i].center.y), radius, tailPaint);
    }
  }

  void renderHead(Canvas canvas) {
    headPaint.color = HSLColor.fromAHSL(0.8, 0, 1.0, 0.4).toColor();
    canvas.drawCircle(Offset(head.center.x, head.center.y), radius, headPaint);
  }

  void update(double t) {
    if (!isDead) {
      var newHead = Circle(
          Point(head.center.x + velocity.x * t, head.center.y + velocity.y * t),
          radius,
          Material(1.0, 5, 0.5, 0.5, true, 0),
          Material(1.0, 5, 0.5, 0.5, true, 0),
          id);
      circles.add(newHead);
      updateTail();
    }
  }

  void updateTail() {
    var tailLength = 0.0;
    var lastIndex = 0;
    for (var i = circles.length - 1; i > 0; i--) {
      var distance = circles[i].center.distanceTo(circles[i - 1].center);
      tailLength += distance;
      if (tailLength > length) {
        lastIndex = i;
        break;
      }
    }
    circles = circles.sublist(lastIndex, circles.length);
  }
}
