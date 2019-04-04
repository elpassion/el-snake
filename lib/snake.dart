import 'dart:math';
import 'dart:ui';

import 'package:el_snake/snake-game.dart';

class Snake {
  final SnakeGame game;
  List<Point<double>> points;
  Point<double> velocity;
  Paint paint = Paint();

  Snake(this.game, double x, double y) {
    points = [Point(x, y)];
    velocity = Point(0, 0);
    paint.color = Color(0xffff0000);
  }

  void render(Canvas canvas) {
    points.forEach((Point<double> point) => canvas.drawCircle(Offset(point.x, point.y), 16, paint));
  }

  void update(double t) {

  }
}