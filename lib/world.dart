import 'dart:math';
import 'dart:ui';

import 'package:el_snake/star.dart';
import 'package:flutter/cupertino.dart';

class World {
  final Point<double> center;
  final double radius;
  final stroke = 16.0;
  final edgesCount = 5;
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
    var c = Offset(center.x, center.y);
    canvas.drawCircle(c, radius, edgePaint);
    for (var i = 1; i < edgesCount; i++) {
      canvas.drawCircle(c, radius * (i / edgesCount), inactiveEdgePaint);
    }
  }

  void update(double t) {
    stars.forEach((Star star) {
      if (isStarTooFar(star)) {
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

  bool isStarTooFar(Star star) {
    return (star.point + star.velocity).distanceTo(center) > radius + 100;
  }
}
