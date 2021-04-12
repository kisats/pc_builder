import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/components/soft_container_material.dart';

class ComponentCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final double price;
  final String infoRow;
  final IconData placeholder;
  final Function() onPlusTap;
  final Function() onTap;
  final EdgeInsets margin;
  final bool showPlus;

  const ComponentCard(
      {Key key,
      this.imgUrl,
      this.name,
      this.price,
      this.infoRow,
      this.placeholder,
      this.onPlusTap,
      this.onTap,
      this.margin,
      this.showPlus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SoftContainerMaterial(
      margin: margin ?? const EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.8 / 1,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: CachedNetworkImage(
                            imageUrl: imgUrl,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Icon(
                              placeholder,
                              size: 40,
                              color: theme.inputDecorationTheme.hintStyle.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 6, right: 6),
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
                                padding: const EdgeInsets.only(top: 2),
                                child: AutoSizeText(
                                  name,
                                  maxLines: 2,
                                  style: theme.textTheme.headline1,
                                ),
                              ),
                            ),
                            showPlus ?? true
                                ? SoftButton(
                                    onTap: onPlusTap,
                                    padding: const EdgeInsets.all(9),
                                    child: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
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
                                          price?.toStringAsFixed(2) ?? " -- ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: AutoSizeText(
                                    infoRow,
                                    maxLines: 1,
                                    style: theme.textTheme.headline3,
                                  ),
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
