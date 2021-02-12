import 'package:flutter/material.dart';

class SoftContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double shadowBlur;
  final double shadowSpread;
  final Offset shadowOffset;
  final Color shadowColor;
  final BorderRadiusGeometry borderRadiusGeom;
  final Color color;
  final List<BoxShadow> shadows;

  const SoftContainer(
      {Key key,
      this.height,
      this.width,
      this.borderRadius,
      this.margin,
      this.padding,
      this.shadowBlur,
      this.shadowSpread,
      this.shadowOffset,
      this.child,
      this.shadowColor,
      this.borderRadiusGeom,
      this.color,
      this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).cardColor,
            borderRadius: borderRadiusGeom ?? BorderRadius.circular(borderRadius ?? 8),
            boxShadow: shadows ??
                [
                  BoxShadow(
                      color: shadowColor ?? Theme.of(context).shadowColor.withOpacity(0.36),
                      offset: shadowOffset ?? Offset(0.0, 2.0),
                      blurRadius: shadowBlur ?? 2,
                      spreadRadius: shadowSpread ?? 1),
                  BoxShadow(
                      color: shadowColor ?? Theme.of(context).shadowColor.withOpacity(0.47),
                      offset: shadowOffset ?? Offset(0.0, 3.0),
                      blurRadius: shadowBlur ?? 9,
                      spreadRadius: shadowSpread ?? 3)
                ]),
        child: Material(
            borderRadius: borderRadiusGeom ?? BorderRadius.circular(borderRadius ?? 8),
            color: color ?? Theme.of(context).cardColor,
            child: child));
  }
}
