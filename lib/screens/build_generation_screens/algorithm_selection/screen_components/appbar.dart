import 'package:flutter/material.dart';
import 'package:pc_builder/components/icons/pop_icon.dart';

class AlgorithmSelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: PopIcon(),
      title: Text(
        "Select Algorithms",
        style: theme.inputDecorationTheme.hintStyle,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
