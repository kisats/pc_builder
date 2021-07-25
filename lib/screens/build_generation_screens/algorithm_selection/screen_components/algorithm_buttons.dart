import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_button.dart';

class AlgorithmButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;

  const AlgorithmButton({this.onTap, this.text, this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: SoftButton(
        margin: const EdgeInsets.all(4),
        color: isSelected ? theme.accentColor : null,
        padding: const EdgeInsets.all(9),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: isSelected
              ? theme.textTheme.headline1.copyWith(color: Colors.white)
              : theme.textTheme.headline1,
        ),
        onTap: isSelected ? null : onTap,
      ),
    );
  }
}
