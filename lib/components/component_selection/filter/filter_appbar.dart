import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/icons/soft_icon_button.dart';

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: SoftIconButton(
          icon: FontAwesomeIcons.angleRight,
          iconSize: 30,
          onTap: Navigator.of(context).pop,
        ),
        title: Text(
          "Filter",
          style: Theme.of(context).textTheme.headline4,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
