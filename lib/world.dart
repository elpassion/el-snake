import 'dart:math';
import 'dart:ui';

import 'package:el_snake/star.dart';
import 'package:flutter/cupertino.dart';

class World {
  final Point<double> center;
  final double radius;
  final stroke = 16.0;
  final random = Random();

  Paint edgePaint;
  Paint inactiveEdgePaint;
  List<Star> stars = [];

  World(this.center, this.radius) {
    createGalaxy();
    edgePaint = Paint()
      ..color = HSLColor.fromAHSL(1.0, 269, 1.0, 0.3).toColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    inactiveEdgePaint = Paint()
      ..color = HSLColor.fromAHSL(1.0, 269, 1.0, 0.05).toColor()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
  }

  void render(Canvas canvas) {
    renderGalaxy(canvas);
    renderEdges(canvas);
  }

  void renderGalaxy(Canvas canvas) {
    stars.forEach((Star star) => star.render(canvas));
  }

  void renderEdges(Canvas canvas) {
    canvas.drawCircle(Offset(center.x, center.y), radius, edgePaint);
    for (var i = 1; i < 5; i++) {
      canvas.drawCircle(Offset(center.x, center.y), radius * (i / 5), inactiveEdgePaint);
    }
  }

  void update(double t) {
    stars.forEach((Star star) {
      if (star.point.distanceTo(center) > radius + 100) {
        star.flipVelocity();
      }
      star.update(t);
    });
  }

  void createGalaxy() {
    for (var i = 0; i < 200; i++) {
      var x = random.nextInt(radius.toInt() * 2) - center.x;
      var y = random.nextInt(radius.toInt() * 2) - center.y;
      var velocity =
          Point(random.nextDouble() * 50 - 25, random.nextDouble() * 50 - 25);
      stars.add(Star(Point(x, y), velocity, (random.nextDouble() * 3) + 1));
    }
  }
}
