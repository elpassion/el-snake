import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Material {
  final double alpha; // 0..1
  final double hue; // 0..360
  final double saturation; // 0..1
  final double lightness; // 0.1
  final bool deadly;
  final double thickness;

  Material(this.alpha, this.hue, this.saturation, this.lightness, this.deadly,
      this.thickness);

  Color get color =>
      HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor();
}
