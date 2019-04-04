import 'dart:math';
import 'dart:ui';

import 'package:el_snake/snake-game.dart';

class Snake {
  final SnakeGame game;
  List<Point<double>> points;
  Point<double> velocity;
  Paint paint = Paint();
  var length = 70;

  Snake(this.game, double x, double y) {
    points = [Point(x, y)];
    velocity = Point(100, 0);
    paint.color = Color(0xffff0000);
  }

  void render(Canvas canvas) {
    points.forEach((Point<double> point) =>
        canvas.drawCircle(Offset(point.x, point.y), 16, paint));
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
