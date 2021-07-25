import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_range_slider.dart';

class ValueSlider extends StatelessWidget {
  final double value;
  final String name;
  final Function(double) onChanged;
  final bool showDivider;
  final double sliderMin;
  final double sliderMax;

  const ValueSlider({Key key, this.value, this.name, this.onChanged, this.showDivider, this.sliderMin, this.sliderMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showDivider ?? true
            ? Divider(
                height: 8,
                color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.8),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(left: 18, top: 8),
          child: Text(name, style: theme.textTheme.headline3.copyWith(fontSize: 16)),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: SizedBox(
                  width: 30,
                  child: Text(value.toStringAsFixed(0), style: theme.textTheme.headline1)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 60),
                child: SoftSlider(
                  min: sliderMin ?? 1,
                  max: sliderMax ?? 9,
                  value: value,
                  noTooltip: true,
                  onChanged: (_, start, end) {
                    onChanged(start);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
