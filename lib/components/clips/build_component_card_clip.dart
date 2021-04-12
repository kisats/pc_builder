import 'package:flutter/material.dart';

class ComponentNameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 30 + 8, 8);
    path.quadraticBezierTo(size.width - 30 + 5, 0, size.width - 30 - 4, 0);
    path.lineTo(8, 0);
    path.quadraticBezierTo(0, 0, 0, 8);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(ComponentNameClipper oldClipper) => false;
}