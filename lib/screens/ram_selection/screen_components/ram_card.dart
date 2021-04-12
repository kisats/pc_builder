import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class RAMCard extends StatelessWidget {
  final RAM ram;
  final EdgeInsets margin;
  final bool showPlus;

  const RAMCard({Key key, this.ram, this.margin, this.showPlus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: ram.name,
      imgUrl: ram.image,
      placeholder: PCParts.memory,
      infoRow: "${ram.memoryType}-${ram.speed}  ·  ${ram.stickCount} x ${ram.stickMemory} GB",
      price: ram.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addRAM(ram);
        Navigator.of(context).pop();
      },
    );
  }
}
