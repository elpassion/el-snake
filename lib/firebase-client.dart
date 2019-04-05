import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_snake/circle.dart';

class FirebaseClient {
  FirebaseClient() {
    Firestore.instance
        .collection("servers/OYyJukO28ZPXWbKR42Yx/circles")
        .snapshots()
        .listen(onDataLoaded);
  }

  void onDataLoaded(QuerySnapshot event) {
    print(event.documents.first.data);
    List<Circle> circles = [];
    event.documents.forEach((DocumentSnapshot snapshot) {
      var circle = createCircle(snapshot.data);
      if (circle != null) {
        circles.add(circle);
      }
    });
    print("circles: $circles");
  }

  Circle createCircle(Map<String, dynamic> data) {
    var center = data["center"];
    if (center == null) return null;
    double x = center["x"].toDouble();
    double y = center["y"].toDouble();
    double radius = data["radius"]?.toDouble();
    var fill = data["fill"];
    var stroke = data["stroke"];
    Material fillMaterial, strokeMaterial;
    if (fill != null) {
      fillMaterial = createMaterial(fill);
    }
    if (stroke != null) {
      strokeMaterial = createMaterial(stroke);
    }
    return Circle(Point(x, y), radius, fillMaterial, strokeMaterial);
  }

  Material createMaterial(Map<dynamic, dynamic> data) => Material(
      data["alpha"].toDouble(),
      data["hue"].toDouble(),
      data["saturation"].toDouble(),
      data["lightness"].toDouble(),
      data["deadly"],
      data["thickness"]?.toDouble() ?? 1.0);
}
