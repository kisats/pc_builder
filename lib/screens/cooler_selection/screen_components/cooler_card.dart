import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/main.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class CoolerCard extends StatelessWidget {
  final Cooler cooler;
  final bool showPlus;
  final EdgeInsets margin;

  const CoolerCard({Key key, this.cooler, this.showPlus, this.margin}) : super(key: key);

  String get infoRow {
    if (rpm == null && noise == null)
      return "";
    else if (rpm == null)
      return noise;
    else if (noise == null)
      return rpm;
    else
      return "$rpm  ·  $noise";
  }

  String get rpm => cooler.minRPM == null && cooler.maxRPM == null
      ? null
      : "${cooler.minRPM ?? 0} - ${cooler.maxRPM ?? 0} RPM";

  String get noise => cooler.minNoise == null && cooler.maxNoise == null
      ? null
      : "${cooler.minNoise?.toStringAsFixed(0) ?? cooler.maxNoise.toStringAsFixed(0)} - ${cooler.maxNoise?.toStringAsFixed(0) ?? cooler.minNoise?.toStringAsFixed(0)} dB";

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: cooler.name,
      imgUrl: cooler.image,
      placeholder: PCParts.cooler,
      infoRow: infoRow,
      price: cooler.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addCooler(cooler);
        Navigator.of(context).pop();
      },
    );
  }
}
