import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/clips/build_component_card_clip.dart';
import 'package:pc_builder/components/clips/clip_shadow.dart';
import 'package:pc_builder/components/soft_button.dart';

class ComponentBuildCard extends StatelessWidget {
  final String componentName;
  final IconData icon;
  final Function() remove;
  final Function() change;
  final Widget componentCard;

  const ComponentBuildCard(
      {Key key, this.componentName, this.icon, this.remove, this.change, this.componentCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipShadowPath(
                  shadow: Shadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.66),
                      offset: Offset(0.0, -2.0),
                      blurRadius: 4),
                  clipper: ComponentNameClipper(),
                  child: Container(
                    color: Theme.of(context).textTheme.headline1.color,
                    padding: const EdgeInsets.only(left: 13, right: 33, top: 13, bottom: 26),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        Text(
                          componentName,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SoftButton(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(11),
                      onTap: change,
                      color: Theme.of(context).buttonColor,
                      child: Icon(
                        FontAwesomeIcons.exchangeAlt,
                        color: Theme.of(context).cardColor,
                        size: 24,
                      ),
                    ),
                    SoftButton(
                      padding: const EdgeInsets.all(11),
                      onTap: remove,
                      color: Colors.redAccent.shade400,
                      child: Icon(
                        FontAwesomeIcons.trash,
                        color: Theme.of(context).cardColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 52),
              child: componentCard,
            ),
          ],
        ));
  }
}
