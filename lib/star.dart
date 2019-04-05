import 'dart:math';
import 'dart:ui';

class Star {
  final double radius;
  Point<double> point;
  Point<double> velocity;
  Paint starPaint;

  Star(this.point, this.velocity, this.radius) {
    starPaint = Paint()
      ..color = Color(0xaaffffff)
      ..style = PaintingStyle.fill;
  }

  void render(Canvas canvas) {
    canvas.drawCircle(Offset(point.x, point.y), radius, starPaint);
  }

  void update(double t) {
    updatePosition(t);
  }

  void updatePosition(double t) {
    point = Point(point.x + velocity.x * t, point.y + velocity.y * t);
  }

  void flipVelocity() {
    velocity = Point(-velocity.x, -velocity.y);
    updatePosition(0.1);
  }
}
