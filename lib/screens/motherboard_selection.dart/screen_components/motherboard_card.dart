import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class MotherboardCard extends StatelessWidget {
  final Motherboard mb;
  final EdgeInsets margin;
  final bool showPlus;

  const MotherboardCard({Key key, @required this.mb, this.margin, this.showPlus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: mb.name,
      imgUrl: mb.image,
      placeholder: PCParts.motherboard,
      infoRow: mb.size + "  ·  " + mb.socket,
      price: mb.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addMotherboard(mb);
        Navigator.of(context).pop();
      },
    );
  }
}
