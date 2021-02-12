import 'package:flutter/material.dart';
import 'package:pc_builder/components/icons/pop_icon.dart';

class NewBuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: PopIcon(),
      actions: [
        /* SoftIconButton(
            icon: FontAwesomeIcons.filter,
            iconSize: 21,
            padding: const EdgeInsets.only(right: 15),
            onTap: () {
              final FocusScopeNode currentScope = FocusScope.of(context);
              if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
              Scaffold.of(context).openEndDrawer();
            },
          ), */
      ],
      title: Text(
        "New Build",
        style: theme.inputDecorationTheme.hintStyle,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
