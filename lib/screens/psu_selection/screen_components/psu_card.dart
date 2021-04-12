import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class PSUCard extends StatelessWidget {
  final PowerSupply psu;
  final bool showPlus;
  final EdgeInsets margin;

  const PSUCard({Key key, this.psu, this.showPlus, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: psu.name,
      imgUrl: psu.image,
      placeholder: PCParts.supply,
      infoRow: "${psu.efficiency}  ·   ${psu.wattage.toStringAsFixed(0)} W",
      price: psu.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addPowerSupply(psu);
        Navigator.of(context).pop();
      },
    );
  }
}
