import 'dart:math';
import 'dart:ui';

class Star {
  final double radius;
  Point<double> point;
  Point<double> velocity;
  Paint starPaint;
  Paint starBrightPaint;

  Star(this.point, this.velocity, this.radius) {
    starPaint = Paint()
      ..color = Color(0x22ffffff);
    starBrightPaint = Paint()
      ..color = Color(0xffffffff);
  }

  void render(Canvas canvas) {
    canvas.drawCircle(Offset(point.x, point.y), radius, starPaint);
    canvas.drawCircle(Offset(point.x, point.y), radius / 2, starBrightPaint);
  }

  void update(double t) {
    point = Point(point.x + velocity.x * t, point.y + velocity.y * t);
  }

  void flipVelocity() {
    velocity = Point(-velocity.x, -velocity.y);
  }
}
