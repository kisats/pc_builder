import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/clips/number_clip.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/components/price_chip.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/new_build_provider.dart';
import 'package:pc_builder/screens/new_build/new_build.dart';
import 'package:provider/provider.dart';

class BuildCard extends StatelessWidget {
  final Build pcBuild;
  final int number;

  const BuildCard({Key key, this.pcBuild, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: [
        SoftContainer(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                SoftContainer(
                  margin: const EdgeInsets.only(bottom: 8),
                  borderRadiusGeom:
                      BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          number != null
                              ? ClipPath(
                                  clipper: BuildNumberClipper(),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 10, right: 18),
                                    color: theme.buttonColor,
                                    child: Text(number.toString(),
                                        style: theme.textTheme.headline1
                                            .copyWith(color: Colors.white)),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              pcBuild.name,
                              maxLines: 2,
                              style: theme.textTheme.headline1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: PriceChip(price: pcBuild.price),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      componentImage(
                        PCParts.cpu,
                        pcBuild.cpu.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.videocard,
                        pcBuild.gpu.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.motherboard,
                        pcBuild.mb.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.memory,
                        pcBuild.ram.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      componentImage(
                        PCParts.ssd,
                        pcBuild.ssd.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.supply,
                        pcBuild.psu.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.cooler,
                        pcBuild.cooler.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                      componentImage(
                        PCParts.case_icon,
                        pcBuild.computerCase.image,
                        theme.inputDecorationTheme.hintStyle.color,
                      ),
                    ],
                  ),
                ),
                SoftContainer(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.all(10),
                  borderRadiusGeom: BorderRadius.only(
                      bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            PCParts.cpu,
                            size: 18,
                            color: theme.textTheme.headline3.color,
                          ),
                          SizedBox(width: 10),
                          AutoSizeText(
                            pcBuild.cpu.name,
                            maxLines: 1,
                            style: theme.textTheme.headline3,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            PCParts.videocard,
                            size: 18,
                            color: theme.textTheme.headline3.color,
                          ),
                          SizedBox(width: 10),
                          AutoSizeText(
                            pcBuild.gpu.chipset,
                            maxLines: 1,
                            style: theme.textTheme.headline3,
                          ),
                        ],
                      ),
                      pcBuild.perfermanceScore != null
                          ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                      "Perfermance Score: ${pcBuild.perfermanceScore.abs().toStringAsFixed(5)}",
                                      textAlign: TextAlign.start,
                                      style: theme.textTheme.headline3),
                                ],
                              ),
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Provider.of<NewBuildProvider>(context, listen: false)
                          .prefillBuild(pcBuild, true);
                      Navigator.of(context).push(FadeRoute(page: NewBuildScreen()));
                    }))),
      ],
    );
  }

  Flexible componentImage(IconData palceholder, String url, Color placeholderColor) {
    return Flexible(
      flex: 1,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Icon(
                palceholder,
                size: 40,
                color: placeholderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
