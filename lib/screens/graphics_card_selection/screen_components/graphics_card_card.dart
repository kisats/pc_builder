import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_card.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/models/video_card.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:provider/provider.dart';

class GraphicCardCard extends StatelessWidget {
  final VideoCard videoCard;
  final bool showPlus;
  final EdgeInsets margin;

  const GraphicCardCard({Key key, this.videoCard, this.showPlus, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: videoCard.name,
      imgUrl: videoCard.image,
      placeholder: PCParts.videocard,
      infoRow: videoCard.chipset + "  ·  " + videoCard.memory.toString() + " GB",
      price: videoCard.price,
      showPlus: showPlus,
      margin: margin,
      onTap: () {},
      onPlusTap: () {
        Provider.of<NewBuildProvider>(context, listen: false).addVideoCard(videoCard);
        Navigator.of(context).pop(); 
      },
    );
  }
}
