import 'package:flutter/material.dart';
import 'package:pc_builder/components/soft_button.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool disabled;

  const ActionButton({Key key, this.title, this.onTap, this.disabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDisabled = disabled ?? false;
    var theme = Theme.of(context);
    return SoftButton(
      height: 50,
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 10),
      color: isDisabled ? theme.buttonColor.withOpacity(0.5) : theme.buttonColor,
      shadows: isDisabled
          ? [
              BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  offset: Offset(0.0, 3.0),
                  blurRadius: 4,
                  spreadRadius: 4)
            ]
          : null,
      onTap: isDisabled ? null : onTap,
      child: Center(
        child: Text(
          title,
          style: theme.textTheme.headline4.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
