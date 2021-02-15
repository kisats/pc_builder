import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/icons/p_c_parts_icons.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/cpu.dart';

class CPUCard extends StatelessWidget {
  final Cpu cpu;

  const CPUCard({Key key, this.cpu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SoftContainer(
      margin: const EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 1,
              child: Row(
                children: [
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: CachedNetworkImage(
                              imageUrl: cpu.image,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => Icon(
                                PCParts.cpu,
                                size: 40,
                                color: theme.inputDecorationTheme.hintStyle.color,
                              ),
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 10, right: 6),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: AutoSizeText(
                                  cpu.name,
                                  maxLines: 2,
                                  style: theme.textTheme.headline1,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(179, 194, 216, 0.4),
                                        offset: Offset(0.0, 3.0),
                                        blurRadius: 3,
                                        spreadRadius: 0.5)
                                  ]),
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(9),
                                    child: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2, left: 3, right: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.green[900].withOpacity(0.67),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 3),
                                            child: Icon(
                                              Icons.euro_rounded,
                                              size: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            cpu.price.toStringAsFixed(2),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  cpu.cores.toString() +
                                      " Cores  ·  " +
                                      cpu.speed.toStringAsFixed(1) +
                                      " GHz",
                                  style: theme.textTheme.headline3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
