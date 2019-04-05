import 'dart:math';
import 'dart:ui';

import 'package:el_snake/circle.dart';
import 'package:el_snake/explosion.dart';
import 'package:el_snake/firebase-client.dart';
import 'package:el_snake/force.dart';
import 'package:el_snake/material.dart';
import 'package:el_snake/random-string.dart';
import 'package:el_snake/restart-button.dart';
import 'package:el_snake/snake.dart';
import 'package:el_snake/world.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

class SnakeGame extends Game {
  final forceFactor = 100;
  final collectionPath = "game";

  Size screenSize;
  Point<double> cameraPosition;
  World world;
  Snake snake;
  List<Snake> botSnakes;
  RestartButton restartButton;
  List<Circle> circles = [];
  List<Explosion> explosions = [];
  FirebaseClient client;
  var random = Random();

//  int magicCounter = 20;

  Point<double> get center =>
      Point(screenSize.width / 2, screenSize.height / 2);

  SnakeGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    world = World(center, 750.0);
    snake = Snake(RandomString(16), this, center);
    botSnakes = [
      Snake(RandomString(16), this, center),
      Snake(RandomString(16), this, center),
      Snake(RandomString(16), this, center),
      Snake(RandomString(16), this, center)
    ];
//    client = FirebaseClient(this, snake);
    createCircles();
    restartButton = RestartButton(center);
  }

  void resize(Size size) {
    screenSize = size;
    super.resize(size);
  }

  void render(Canvas canvas) {
    canvas.translate(cameraPosition.x, cameraPosition.y);
    world.render(canvas);
    snake.render(canvas);
    botSnakes.forEach((Snake snake) => snake.render(canvas));
    circles.forEach((Circle circle) => circle.render(canvas));
    explosions.forEach((Explosion explosion) => explosion.render(canvas));
    canvas.translate(-cameraPosition.x, -cameraPosition.y);
    if (snake.isDead) {
      restartButton.render(canvas);
    }
  }

  void update(double t) {
    updateCamera();
    if (!snake.isDead && collidesWithAnything(snake)) {
      snake.isDead = true;
      explosions.add(Explosion(snake.head.center));
    }
    botSnakes.forEach((Snake snake) {
      if (!snake.isDead && collidesWithAnything(snake)) {
        snake.isDead = true;
        botSnakes.remove(snake);
        botSnakes.add(Snake(RandomString(16), this, center));
      }
    });

    world.update(t);
    snake.update(t);
    botSnakes.forEach((Snake snake) => snake.update(t));
    explosions.forEach((Explosion explosion) => explosion.update(t));
    /*if (magicCounter <= 0) {
      magicCounter = 20;
      client.updateMyCircles();
    } else {
      magicCounter--;
    }*/
  }

  bool collidesWithAnything(Snake snake) =>
      collidesWithWorldEdge(snake) || collidesWithDeadlyCircle(snake);

  bool collidesWithDeadlyCircle(Snake snake) {
    if (snake.head.center.distanceTo(world.center) > snake.head.radius * 3) {
      return circles.any((Circle c) => snake.head.collidesWith(c));
    } else {
      return false;
    }
  }

  void updateCamera() {
    var dx = -snake.head.center.x + screenSize.width / 2;
    var dy = -snake.head.center.y + screenSize.height / 2;
    cameraPosition = Point(dx, dy);
  }

  void onForce(Force force) {
    snake?.velocity = Point(-force.x * forceFactor, force.y * forceFactor);
    botSnakes.forEach((Snake snake) {
      snake.velocity = Point(snake.velocity.x + random.nextInt(20) - 10,
          snake.velocity.y + random.nextInt(20) - 10);
    });
  }

  void onTapDown(TapDownDetails tap) {
    if (snake.isDead) {
      restartGame();
    }
  }

  void restartGame() {
    cameraPosition = Point(0, 0);
    explosions.clear();
    snake = Snake(snake.id, this, center);
  }

  bool collidesWithWorldEdge(Snake snake) {
    var distanceToCenter = snake.head.center.distanceTo(world.center);
    return distanceToCenter + snake.radius >= world.radius - world.stroke / 2;
  }

  void createCircles() {
    for (var i = 0; i < 70; i++) {
      var radius = random.nextInt(15) + 5;
      var x = random.nextInt(world.radius.toInt() * 2) - center.x;
      var y = random.nextInt(world.radius.toInt() * 2) - center.y;
      Point(random.nextDouble() * 100 - 50, random.nextDouble() * 100 - 50);
      var hue = random.nextInt(360).toDouble();
      circles.add(Circle(
          Point(x, y),
          radius.toDouble(),
          Material(1.0, hue, 1.0, 0.5, true, 0),
          Material(1.0, hue, 1.0, 0.5, true, 3),
          RandomString(5)));
    }
  }
}
