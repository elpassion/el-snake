import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_snake/explosion.dart';
import 'package:el_snake/force.dart';
import 'package:el_snake/restart-button.dart';
import 'package:el_snake/snake.dart';
import 'package:el_snake/world.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SnakeGame extends Game {
  final forceFactor = 50;
  final collectionPath = "game";

  Size screenSize;
  var dx, dy;
  World world;
  Snake snake;
  RestartButton restartButton;
  List<Explosion> explosions = [];

  Point<double> get center =>
      Point(screenSize.width / 2, screenSize.height / 2);

  SnakeGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    world = World(center, 750.0);
    snake = Snake("id", this, center);
//    Firestore.instance.collection(collectionPath).snapshots().listen(this.onDataLoaded);
    restartButton = RestartButton(center);
  }

  void onDataLoaded(QuerySnapshot event) {
//    snake = Snake(event.documents.last.documentID, this, center);
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
    explosions.forEach((Explosion explosion) => explosion.render(canvas));
  }

  void update(double t) {
    updateCamera();
    if (!snake.isDead && collidesWithWorld()) {
      snake.isDead = true;
      explosions.add(Explosion(snake.head));
    }
    world.update(t);
    snake.update(t);
    explosions.forEach((Explosion explosion) => explosion.update(t));
    increaseSnakeLength(snake.id, snake.length);
  }

  void updateCamera() {
    var snakeHead = snake.points.last;
    dx = -snakeHead.x + screenSize.width / 2;
    dy = -snakeHead.y + screenSize.height / 2;
  }

  void onForce(Force force) {
    snake?.velocity = Point(force.x * forceFactor, -force.y * forceFactor);
  }

  void onTapDown(TapDownDetails tap) {
    if (snake.isDead) {
      restartGame();
    }
  }

  void restartGame() {
    dx = 0;
    dy = 0;
    explosions.clear();
    snake = Snake(snake.id, this, center);
    setDefaultSnakeLength(snake.id);
  }

  bool collidesWithWorld() {
    var distanceToCenter = snake.head.distanceTo(world.center);
    return distanceToCenter + snake.radius >= world.radius - world.stroke / 2;
  }

  void onDataChanged(QuerySnapshot event) {
    print(event);
  }

  void increaseSnakeLength(String documentId, int snakeLength) {
    var data = Map<String, int>();
    data["length"] = snakeLength++;
    Firestore.instance.collection(collectionPath).document(documentId).updateData(data);
  }

  void setDefaultSnakeLength(String documentId) {
    var data = Map<String, int>();
    data["length"] = 0;
    Firestore.instance.collection(collectionPath).document(documentId).updateData(data);
  }
}
