import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';

class RestartButton {
  Rect rect;
  Sprite sprite;

  RestartButton(Point<double> point) {
    sprite = Sprite('restart-button.png');
    rect = Rect.fromLTWH(point.x - 140, point.y + 300, 280, 20);
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}
}
