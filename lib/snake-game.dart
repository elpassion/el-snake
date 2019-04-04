import 'dart:ui';

import 'package:el_snake/force.dart';
import 'package:el_snake/snake.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class SnakeGame extends Game {
  Size screenSize;
  Snake snake;
  Force force;

  SnakeGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    snake = Snake(this, screenSize.width / 2, screenSize.height / 2);
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xffaabbcc);
    canvas.drawRect(bgRect, bgPaint);
    snake.render(canvas);
  }

  void update(double t) {
    snake.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }
}
