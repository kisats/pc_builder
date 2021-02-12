import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SoftRangeSlider extends StatelessWidget {
  final double min;
  final double max;

  final double start;
  final double end;

  final double devideBy;
  final String suffix;

  final List<FlutterSliderFixedValue> fixedValues;
  final Function(String) format;

  final Function(int, dynamic, dynamic) onChanged;

  const SoftRangeSlider(
      {Key key,
      this.min,
      this.max,
      this.start,
      this.end,
      this.devideBy,
      this.suffix,
      this.onChanged,
      this.fixedValues,
      this.format})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FlutterSlider(
      min: devideBy != null ? min * devideBy : min,
      max: devideBy != null ? max * devideBy : max,
      touchSize: 5,
      handlerHeight: 28,
      handlerWidth: 60,
      jump: false,
      selectByTap: false,
      fixedValues: fixedValues,
      trackBar: FlutterSliderTrackBar(
          activeTrackBarDraggable: false,
          inactiveDisabledTrackBarColor: theme.scaffoldBackgroundColor,
          inactiveTrackBarHeight: 7,
          activeTrackBarHeight: 8,
          inactiveTrackBar: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(179, 194, 216, 0.6),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1,
                    spreadRadius: 0.5),
              ]),
          activeTrackBar: BoxDecoration(color: Color.fromRGBO(88, 191, 244, 1.0), boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(179, 194, 216, 0.6),
                offset: Offset(0.0, 1.0),
                blurRadius: 1,
                spreadRadius: 0.5),
          ])),
      handler: handler(context),
      rightHandler: handler(context),
      rangeSlider: true,
      onDragCompleted: onChanged,
      values: [
        devideBy != null ? start * devideBy : start,
        devideBy != null ? end * devideBy : end
      ],
      tooltip: FlutterSliderTooltip(
          alwaysShowTooltip: true,
          format: format ??
              (value) {
                if (devideBy != null)
                  return (double.tryParse(value) / devideBy).toStringAsFixed(devideBy ~/ 10);

                return value.substring(0, value.indexOf("."));
              },
          rightSuffix: suffix != null
              ? Text(suffix, style: theme.textTheme.headline1.copyWith(fontWeight: FontWeight.w600))
              : null,
          leftSuffix: suffix != null
              ? Text(suffix, style: theme.textTheme.headline1.copyWith(fontWeight: FontWeight.w600))
              : null,
          positionOffset: FlutterSliderTooltipPositionOffset(top: -20),
          textStyle: theme.textTheme.headline1,
          boxStyle: FlutterSliderTooltipBox()),
    );
  }

  FlutterSliderHandler handler(BuildContext context) {
    return FlutterSliderHandler(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(179, 194, 216, 0.4),
              offset: Offset(0.0, 0.5),
              blurRadius: 2,
              spreadRadius: 1),
          BoxShadow(
              color: Color.fromRGBO(179, 194, 216, 0.4),
              offset: Offset(0.0, 3.0),
              blurRadius: 3,
              spreadRadius: 1)
        ]),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).inputDecorationTheme.hintStyle.color.withOpacity(0.7),
          ),
        ));
  }
}
