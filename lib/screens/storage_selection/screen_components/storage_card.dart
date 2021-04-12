import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class StorageCard extends StatelessWidget {
  final SSD ssd;
  final bool showPlus;
  final EdgeInsets margin;

  const StorageCard({Key key, this.ssd, this.showPlus, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: ssd.name,
      imgUrl: ssd.image,
      placeholder: PCParts.memory,
      infoRow: "${ssd.capacity.toStringAsFixed(0)} GB   ·   ${ssd.isNVME ? "NVMe" : "SATA"}",
      price: ssd.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addSSD(ssd);
        Navigator.of(context).pop();
      },
    );
  }
}