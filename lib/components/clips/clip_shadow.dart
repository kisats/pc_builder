import 'package:flutter/material.dart';

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ImageShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class ClipShadowRRect extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<RRect> clipper;
  final Widget child;

  ClipShadowRRect({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ImageShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRRect(child: child, clipper: this.clipper),
    );
  }
}

class _ImageShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper clipper;

  _ImageShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}