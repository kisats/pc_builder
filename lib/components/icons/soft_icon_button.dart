import 'package:flutter/material.dart';

class SoftIconButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final double iconSize;
  final EdgeInsets padding;
  final Color color;

  const SoftIconButton({Key key, this.onTap, this.icon, this.iconSize, this.padding, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return IconButton(
      padding: padding ?? const EdgeInsets.only(right: 8, left: 8),
      visualDensity: VisualDensity(
          vertical: VisualDensity.minimumDensity, horizontal: VisualDensity.minimumDensity),
      splashRadius: 30,
      highlightColor: theme.iconTheme.color.withOpacity(0.2),
      onPressed: onTap,
      icon: Icon(
        icon,
        size: iconSize ?? 23,
        color: color ?? theme.iconTheme.color,
      ),
    );
  }
}
