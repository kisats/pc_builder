import 'package:flutter/material.dart';

class SoftButton extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadiusGeom;
  final double borderRadius;
  final double height;
  final double width;
  final Color color;
  final Function onTap;
  final Widget child;
  final List<BoxShadow> shadows;

  const SoftButton(
      {Key key,
      this.margin,
      this.padding,
      this.height,
      this.width,
      this.color,
      this.borderRadiusGeom,
      this.borderRadius,
      this.onTap,
      this.child,
      this.shadows})
      : super(key: key);

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  double firstBlur;
  double secondBlur;
  double firstSpread;
  double secondSpread;
  double firstOpacity;
  double secondOpacity;

  @override
  void initState() {
    firstBlur = 2;
    secondBlur = 9;
    firstSpread = 1;
    secondSpread = 3;
    firstOpacity = 0.36;
    secondOpacity = 0.42;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 220),
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).cardColor,
            borderRadius:
                widget.borderRadiusGeom ?? BorderRadius.circular(widget.borderRadius ?? 8),
            boxShadow: widget.shadows ??
                [
                  BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(firstOpacity),
                      offset: Offset(0.0, 2.0),
                      blurRadius: firstBlur,
                      spreadRadius: firstSpread),
                  BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(secondOpacity),
                      offset: Offset(0.0, 3.0),
                      blurRadius: secondBlur,
                      spreadRadius: secondSpread)
                ]),
        child: Material(
            borderRadius:
                widget.borderRadiusGeom ?? BorderRadius.circular(widget.borderRadius ?? 8),
            color: widget.color ?? Theme.of(context).cardColor,
            child: InkWell(
              onTapDown: _onTapDown,
              onTap: () {
                _onTapUp();
                widget.onTap();
              },
              onTapCancel: _onTapUp,
              borderRadius:
                  widget.borderRadiusGeom ?? BorderRadius.circular(widget.borderRadius ?? 8),
              child: Padding(
                padding: widget.padding ?? EdgeInsets.zero,
                child: widget.child,
              ),
            )));
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      firstBlur = 0.5;
      secondBlur = 1;
      firstSpread = 0.1;
      secondSpread = 0.5;
      firstOpacity = 0.20;
      secondOpacity = 0.25;
    });
  }

  void _onTapUp() {
    setState(() {
      firstBlur = 2;
      secondBlur = 9;
      firstSpread = 1;
      secondSpread = 3;
      firstOpacity = 0.36;
      secondOpacity = 0.42;
    });
  }
}
