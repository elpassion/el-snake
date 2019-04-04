import 'dart:math';
import 'dart:ui';

import 'package:el_snake/force.dart';
import 'package:el_snake/restart-button.dart';
import 'package:el_snake/snake.dart';
import 'package:el_snake/world.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SnakeGame extends Game {
  final forceFactor = 50;

  Size screenSize;
  var dx, dy;
  World world;
  Snake snake;
  RestartButton restartButton;

  Point<double> get center => Point(screenSize.width / 2, screenSize.height / 2);

  SnakeGame() {
    initialize();
  }

  void initialize() async {
    Firestore.instance.collection("game").snapshots().listen(onData);
    resize(await Flame.util.initialDimensions());
    world = World(center, 750.0);
    spawnNewSnake();
    restartButton = RestartButton(center);
  }

  void spawnNewSnake() {
    snake = Snake(this, center);
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void render(Canvas canvas) {
    if (snake.isDead) {
      restartButton.render(canvas);
    }
    canvas.translate(dx, dy);
    world.render(canvas);
    snake.render(canvas);
  }

  void update(double t) {
    updateCamera();
    if (collidesWithWorld()) {
      snake.isDead = true;
    }
    snake.update(t);
  }

  void updateCamera() {
    var snakeHead = snake.points.last;
    dx = -snakeHead.x + screenSize.width / 2;
    dy = -snakeHead.y + screenSize.height / 2;
  }

  void onForce(Force force) {
    snake.velocity = Point(force.x * forceFactor, -force.y * forceFactor);
  }

  void onTapDown(TapDownDetails tap) {
    if (snake.isDead) {
      restartGame();
    }
  }

  void restartGame() {
    dx = 0;
    dy = 0;
    spawnNewSnake();
  }

  bool collidesWithWorld() {
    var distanceToCenter = snake.head.distanceTo(world.center);
    return distanceToCenter + snake.radius >= world.radius - world.stroke / 2;
  }

  void onData(QuerySnapshot event) {
    print(event);
  }
}
