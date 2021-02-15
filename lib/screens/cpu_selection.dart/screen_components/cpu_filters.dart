import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_range_slider.dart';
import 'package:pc_builder/components/soft_switch.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_filter_provider.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:provider/provider.dart';
import 'package:pc_builder/models/filters/cpu_selection_filter.dart';

class CpuFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<FilterProvider>(
      builder: (_, value, __) {
        var state = value as CPUSelectionFilterProvider;
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
                              child: DropdownButton<CPUSort>(
                                icon: Container(),
                                value: state.filter.sort,
                                isExpanded: true,
                                underline: Container(),
                                onChanged: (sort) {
                                  state.setSort(sort);
                                },
                                items: [
                                  DropdownMenuItem(
                                      value: CPUSort.none,
                                      child: Center(
                                        child: AutoSizeText("--",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                  DropdownMenuItem(
                                      value: CPUSort.cores,
                                      child: Center(
                                        child: AutoSizeText("Cores",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                  DropdownMenuItem(
                                      value: CPUSort.clock,
                                      child: Center(
                                        child: AutoSizeText("Clock",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                  DropdownMenuItem(
                                      value: CPUSort.price,
                                      child: Center(
                                        child: AutoSizeText("Price",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                  DropdownMenuItem(
                                      value: CPUSort.consumption,
                                      child: Center(
                                        child: AutoSizeText("Consumption",
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.headline1),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SoftContainer(
                            shadowColor: state.filter.sort == CPUSort.none
                                ? theme.shadowColor.withOpacity(0.1)
                                : null,
                            child: InkWell(
                                onTap:
                                    state.filter.sort == CPUSort.none ? null : state.setSortOrder,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Icon(
                                    state.filter.order == SortOrder.ascending
                                        ? FontAwesomeIcons.sortAmountDownAlt
                                        : FontAwesomeIcons.sortAmountDown,
                                    color: state.filter.sort == CPUSort.none
                                        ? theme.iconTheme.color.withOpacity(0.5)
                                        : theme.iconTheme.color,
                                  ),
                                )),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SoftContainer(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AMD",
                        style: theme.textTheme.headline1,
                      ),
                      SoftSwitch(
                        value: state.filter.showAmd,
                        onChange: state.setAMD,
                      ),
                    ],
                  ),
                  Container(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Intel",
                        style: theme.textTheme.headline1,
                      ),
                      SoftSwitch(
                        value: state.filter.showIntel,
                        onChange: state.setIntel,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SoftContainer(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15, left: 18, right: 10),
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
                    padding: const EdgeInsets.only(top: 10, bottom: 15, left: 18, right: 10),
                    child:
                        Text("Core Count", style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                  ),
                  SoftRangeSlider(
                    min: state.minCores.toDouble(),
                    max: state.maxCores.toDouble(),
                    start: state.getCoreCountPrecent(state.filter.selectedMinCores).toDouble(),
                    end: state.getCoreCountPrecent(state.filter.selectedMaxCores).toDouble(),
                    fixedValues: state.cores
                        .map((e) => FlutterSliderFixedValue(
                              percent: state.getCoreCountPrecent(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (_, start, end) {
                      state.setCores(start, end);
                    },
                    format: (a) => a,
                  ),
                  Divider(
                    height: 8,
                    color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.7),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15, left: 18, right: 10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Core Clock ", style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                      Text(
                        "GHz",
                        style: theme.textTheme.headline3
                            .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ]),
                  ),
                  SoftRangeSlider(
                    min: state.minClock,
                    max: state.maxClock,
                    start: state.filter.selectedMinClock,
                    end: state.filter.selectedMaxClock,
                    onChanged: (_, start, end) {
                      state.setClock(((start as double) / 10), (end as double) / 10);
                    },
                    devideBy: 10,
                  ),
                  Divider(
                    height: 8,
                    color: theme.inputDecorationTheme.hintStyle.color.withOpacity(0.7),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15, left: 18, right: 10),
                    child: Text("Consumption",
                        style: theme.textTheme.headline3.copyWith(fontSize: 16)),
                  ),
                  SoftRangeSlider(
                    min: state.minConsumption.toDouble(),
                    max: state.maxConsumption.toDouble(),
                    start: state.filter.selectedMinConsumption.toDouble(),
                    end: state.filter.selectedMaxConsumption.toDouble(),
                    onChanged: (_, start, end) {
                      state.setConsumption((start as double).toInt(), (end as double).toInt());
                    },
                    suffix: " W",
                  ),
                ],
              ),
            ),
            Container(height: 10),
          ],
        );
      },
    );
  }
}
