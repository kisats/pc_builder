import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/icons/soft_icon_button.dart';

class PopIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SoftIconButton(
        onTap: Navigator.of(context).pop, icon: FontAwesomeIcons.angleLeft, iconSize: 32);
  }
}
