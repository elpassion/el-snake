import 'dart:math';
import 'dart:ui';

import 'package:el_snake/force.dart';
import 'package:el_snake/snake.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class SnakeGame extends Game {
  final int forceFactor = 50;
  Size screenSize;
  Snake snake;

  SnakeGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    snake = Snake(this, screenSize.width / 2, screenSize.height / 2);
  }

  void render(Canvas canvas) {
    var snakeHead = snake.points.last;
    var dx = -snakeHead.x + screenSize.width / 2;
    var dy = -snakeHead.y + screenSize.height / 2;
    canvas.translate(dx, dy);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff114411);
    canvas.drawCircle(Offset(0, 0), 500, bgPaint);
    snake.render(canvas);
  }

  void update(double t) {
    snake.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void onForce(Force force) {
    snake.velocity = Point(force.x * forceFactor, -force.y * forceFactor);
  }
}
