import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class CaseCard extends StatelessWidget {
  final Case model;
  final bool showPlus;
  final EdgeInsets margin;

  const CaseCard({Key key, this.model, this.showPlus, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: model.name,
      imgUrl: model.image,
      placeholder: PCParts.case_icon,
      infoRow: model.type,
      price: model.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addCase(model);
        Navigator.of(context).pop();
      },
    );
  }
}
