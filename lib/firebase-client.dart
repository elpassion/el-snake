import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_snake/circle.dart';
import 'package:el_snake/material.dart';
import 'package:el_snake/snake.dart';

class FirebaseClient {
  final Snake snake;
  var collectionPath = "servers/OYyJukO28ZPXWbKR42Yx/circles";

  FirebaseClient(this.snake) {
    Firestore.instance
        .collection(collectionPath)
        .snapshots()
        .listen(onDataLoaded);
  }

  void onDataLoaded(QuerySnapshot event) {
    print(event.documents.first.data);
    List<Circle> circles = event.documents
        .map((DocumentSnapshot snapshot) => toCircle(snapshot.data))
        .where((Circle circle) => circle != null && circle.radius != null)
        .toList();
    print("circles: $circles");
  }

  void updateMyCircles() async {
    var querySnapshot = await Firestore.instance
        .collection(collectionPath)
        .where("snake_id", isEqualTo: snake.id)
        .getDocuments();

    var documents = querySnapshot.documents;
    for (var i = 0; i < documents.length; i++) {
      await Firestore.instance.document(collectionPath + "/" + documents[i].documentID).delete();
    }

    await Firestore.instance
        .collection(collectionPath)
        .document()
        .setData(fromCircle(snake.head))
        .then((value) => print("ADDED CIRCLE TO SERVER"));
  }

  Map<String, dynamic> fromCircle(Circle circle) {
    return {
      'snake_id': circle.snakeId,
      'center': {'x': circle.center.x, 'y': circle.center.y},
      'radius': circle.radius,
      'fill': fromMaterial(circle.fill),
      'stroke': fromMaterial(circle.stroke)
    };
  }

  Map<String, dynamic> fromMaterial(Material material) {
    return {
      'alpha': material.alpha,
      'hue': material.hue,
      'saturation': material.saturation,
      'lightness': material.lightness,
      'deadly': material.deadly,
      'thickness': material.thickness
    };
  }

  Circle toCircle(Map<String, dynamic> data) {
    var center = data["center"];
    if (center == null) return null;
    double x = center["x"].toDouble();
    double y = center["y"].toDouble();
    double radius = data["radius"]?.toDouble();
    var fill = data["fill"];
    var stroke = data["stroke"];
    var snakeId = data["snake_id"];
    Material fillMaterial, strokeMaterial;
    if (fill != null) {
      fillMaterial = createMaterial(fill);
    }
    if (stroke != null) {
      strokeMaterial = createMaterial(stroke);
    }
    return Circle(Point(x, y), radius, fillMaterial, strokeMaterial, snakeId);
  }

  Material createMaterial(Map<dynamic, dynamic> data) => Material(
      data["alpha"].toDouble(),
      data["hue"].toDouble(),
      data["saturation"].toDouble(),
      data["lightness"].toDouble(),
      data["deadly"],
      data["thickness"]?.toDouble() ?? 1.0);
}
