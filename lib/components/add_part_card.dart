import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/soft_container_material.dart';

class AddPartCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const AddPartCard({Key key, this.icon, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SoftContainerMaterial(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      icon,
                      color: Theme.of(context).textTheme.headline1.color,
                      size: 28,
                    ),
                  ),
                  Text(text, style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20)),
                ],
              ),
              Icon(FontAwesomeIcons.plus),
            ],
          ),
        ),
      ),
    );
  }
}
