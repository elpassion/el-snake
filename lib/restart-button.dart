import 'dart:ui';

import 'package:flame/sprite.dart';

class RestartButton {
  Rect rect;
  Sprite sprite;

  RestartButton(double x, double y) {
    sprite = Sprite('restart-button.png');
    rect = Rect.fromLTWH(x - 140, y + 300, 280, 20);
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
  }

  void update(double t) {}
}
