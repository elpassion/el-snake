import 'package:el_snake/force.dart';
import 'package:el_snake/snake-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SnakeGame game = SnakeGame();
  runApp(game.widget);
  accelerometerEvents.listen((AccelerometerEvent event) {
    game.force = Force(event.x, event.y, event.z);
  });
}
