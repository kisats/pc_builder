import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/components/soft_container.dart';

class FilterBottomButtons extends StatelessWidget {
  final Function() onClear;
  final Function() onApply;
  final bool disabledApply;
  final bool disabledClear;

  const FilterBottomButtons(
      {Key key, this.onClear, this.onApply, this.disabledApply, this.disabledClear})
      : super(key: key);

  bool get clearDisabled => disabledClear != null && disabledClear;
  bool get applyDisabled => disabledApply != null && disabledApply;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: SoftButton(
            height: 50,
            margin: const EdgeInsets.only(left: 16, right: 8, top: 15, bottom: 15),
            color: theme.buttonColor.withOpacity(applyDisabled ? 0.2 : 1.0),
            shadows: applyDisabled
                ? [
                    BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.33),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 3,
                        spreadRadius: 1),
                  ]
                : null,
            onTap: applyDisabled ? null : onApply,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    FontAwesomeIcons.filter,
                    size: 20,
                    color: Colors.white.withOpacity(applyDisabled ? 0.6 : 1.0),
                  ),
                ),
                Text(
                  "Apply",
                  style: theme.textTheme.headline4
                      .copyWith(color: Colors.white.withOpacity(applyDisabled ? 0.6 : 1.0)),
                ),
              ],
            ),
          ),
        ),
        SoftButton(
          margin: const EdgeInsets.only(left: 7, right: 16, top: 12, bottom: 12),
          height: 50,
          width: 50,
          color: Colors.redAccent[400].withOpacity(clearDisabled ? 0.2 : 1.0),
          onTap: clearDisabled ? null : onClear,
          shadows: clearDisabled
              ? [
                  BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.33),
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3,
                      spreadRadius: 1),
                ]
              : null,
          child: Icon(
            FontAwesomeIcons.times,
            size: 30,
            color: Colors.white.withOpacity(clearDisabled ? 0.6 : 1.0),
          ),
        ),
      ],
    );
  }
}
