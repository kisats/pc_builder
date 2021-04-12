import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class CPUCard extends StatelessWidget {
  final Cpu cpu;
  final EdgeInsets margin;
  final bool showPlus;

  const CPUCard({Key key, this.cpu, this.margin, this.showPlus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: cpu.name,
      imgUrl: cpu.image,
      placeholder: PCParts.cpu,
      infoRow: cpu.cores.toString() + " Cores  ·  " + cpu.speed.toStringAsFixed(1) + " GHz",
      price: cpu.price,
      margin: margin,
      showPlus: showPlus,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addCpu(cpu);
        Navigator.of(context).pop();
      },
    );
  }
}
