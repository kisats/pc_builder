import 'package:flutter/material.dart';
import 'package:pc_builder/components/custom_switch.dart';

class SoftSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChange;

  const SoftSwitch({Key key, this.value, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomSwitch(
      value: value,
      onChanged: onChange,
      switchExtent: 8,
      switchRadius: 11,
      switchHeight: 30,
      switchWidth: 60,
      trackHeight: 30,
      trackWidth: 60,
      trackColor: theme.scaffoldBackgroundColor,
      activeColor: Color.fromRGBO(88, 191, 244, 0.8),
      switchColor: Theme.of(context).cardColor,
      shadows: <BoxShadow>[
        BoxShadow(
          color: theme.shadowColor.withOpacity(0.7),
          offset: Offset(0, 2),
          blurRadius: 8.0,
        ),
        BoxShadow(
          color: theme.shadowColor.withOpacity(0.4),
          offset: Offset(0, 0),
          blurRadius: 1.0,
        ),
      ],
    );
  }
}
