import 'package:el_snake/force.dart';
import 'package:el_snake/snake-game.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>['restart-button.png']);

  SnakeGame game = SnakeGame();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  runApp(game.widget);
  accelerometerEvents.listen((AccelerometerEvent event) {
    game.onForce(Force(event.x, event.y, event.z));
  });
  flameUtil.addGestureRecognizer(tapper);
}
