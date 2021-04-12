import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_range_slider.dart';
import 'package:pc_builder/components/soft_switch.dart';
import 'package:pc_builder/models/filters/motherboard_selection_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_filter_provider.dart';
import 'package:provider/provider.dart';

class MotherboardFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<FilterProvider>(
      builder: (_, value, __) {
        var state = value as MotherboardSelectionFilterProvider;
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(height: 5),
            SoftContainer(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 15),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Text(
                      "Sort By:",
                      style: theme.textTheme.headline1,
                    ),
                  ),
                  Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          Expanded(
                            child: SoftContainer(
                              margin: const EdgeInsets.only(right: 8),
                              child: DropdownButton<MotherboardSort>(
                                icon: Container(),
                                value: state.filter.sort,
                                isExpanded: true,
                                underline: Container(),
                                onChanged: (sort) {
                                  state.setSort(sort);
                                },
                                items: [
                                  DropdownMenuItem(
                                      value: MotherboardSort.none,
                                      child: Center(
                                        child: AutoSizeText("--",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                  DropdownMenuItem(
                                      value: MotherboardSort.price,
                                      child: Center(
                                        child: AutoSizeText("Price",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SoftButton(
                            shadows: state.filter.sort == MotherboardSort.none
                                ? [
                                    BoxShadow(
                                        color: Theme.of(context).shadowColor.withOpacity(0.33),
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 3,
                                        spreadRadius: 1),
                                  ]
                                : null,
                            onTap: state.filter.sort == MotherboardSort.none
                                ? null
                                : state.setSortOrder,
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              state.filter.order == SortOrder.ascending
                                  ? FontAwesomeIcons.sortAmountDownAlt
                                  : FontAwesomeIcons.sortAmountDown,
                              color: state.filter.sort == MotherboardSort.none
                                  ? theme.iconTheme.color.withOpacity(0.5)
                                  : theme.iconTheme.color,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SoftContainer(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Text("Price ", style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                  ),
                  SoftRangeSlider(
                    min: state.getPriceValue(state.minPrice),
                    max: state.getPriceValue(state.maxPrice),
                    start: state.getPriceValue(state.filter.selectedMinPrice),
                    end: state.getPriceValue(state.filter.selectedMaxPrice),
                    onChanged: (_, start, end) {
                      state.setPrice(state.getPriceFromValue(start), state.getPriceFromValue(end));
                    },
                    format: (text) {
                      var value = double.tryParse(text);
                      var price = state.getPriceFromValue(value);
                      if (price > state.maxPrice) price = state.maxPrice;
                      if (price < state.minPrice) price = state.minPrice;
                      return price.toStringAsFixed(0);
                    },
                    suffix: " €",
                  ),
                  Divider(
                    height: 8,
                    color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 15,
                    ),
                    child:
                        Text("RAM Slots", style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                  ),
                  SoftRangeSlider(
                    min: state.minRAMSlots.toDouble(),
                    max: state.maxRAMSlots.toDouble(),
                    start: state.filter.ramSlotsMin.toDouble(),
                    end: state.filter.ramSlotsMax.toDouble(),
                    onChanged: (_, start, end) {
                      state.setRAMSlots((start as double).toInt(), (end as double).toInt());
                    },
                  ),
                ],
              ),
            ),
            SoftContainer(
                margin: const EdgeInsets.all(8),
                child: AppExpansionTile(
                  controller: state.sizeController,
                  initiallyExpanded: !state.filter.allSizes,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 15, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Form Factor",
                            style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                "All",
                                style: theme.textTheme.headline1,
                              ),
                            ),
                            SoftSwitch(
                              value: state.filter.allSizes,
                              onChange: state.setAllSizes,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Divider(
                      height: 4,
                      color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.7),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: state.sizes.map((e) {
                                    bool isSelected = state.filter.size.contains(e);
                                    return SoftButton(
                                      color: isSelected ? theme.accentColor : null,
                                      shadows: [
                                        BoxShadow(
                                            color: Theme.of(context).shadowColor.withOpacity(0.56),
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 2,
                                            spreadRadius: 1.5)
                                      ],
                                      padding: const EdgeInsets.only(
                                          top: 6, bottom: 6, left: 8, right: 8),
                                      child: Text(
                                        e,
                                        style: isSelected
                                            ? theme.textTheme.headline1
                                                .copyWith(color: Colors.white)
                                            : theme.textTheme.headline1,
                                      ),
                                      onTap: () =>
                                          isSelected ? state.removeSize(e) : state.addSize(e),
                                    );
                                  }).toList()),
                            ),
                          ],
                        )),
                  ],
                )),
            SoftContainer(
              margin: const EdgeInsets.all(8),
              child: AppExpansionTile(
                  controller: state.socketController,
                  initiallyExpanded: !state.filter.allSockets,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 15, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Socket", style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                "All",
                                style: theme.textTheme.headline1,
                              ),
                            ),
                            SoftSwitch(
                              value: state.filter.allSockets,
                              onChange: state.setAllSockets,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Divider(
                      height: 4,
                      color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.7),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 6),
                        child: Row(children: [
                          Expanded(
                            child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: WrapAlignment.spaceBetween,
                                children: state.sockets.map((e) {
                                  bool isSelected = state.filter.sockets.contains(e);
                                  return SoftButton(
                                    color: isSelected ? theme.accentColor : null,
                                    shadows: [
                                      BoxShadow(
                                          color: Theme.of(context).shadowColor.withOpacity(0.56),
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2,
                                          spreadRadius: 1.5)
                                    ],
                                    padding:
                                        const EdgeInsets.only(top: 6, bottom: 6, left: 8, right: 8),
                                    child: Text(
                                      e,
                                      style: isSelected
                                          ? theme.textTheme.headline1.copyWith(color: Colors.white)
                                          : theme.textTheme.headline1,
                                    ),
                                    onTap: () =>
                                        isSelected ? state.removeSocket(e) : state.addSocket(e),
                                  );
                                }).toList()),
                          )
                        ]))
                  ]),
            ),
            Container(height: 10),
          ],
        );
      },
    );
  }
}
