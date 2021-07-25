import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/best_criteria_selection_provider.dart';
import 'package:pc_builder/providers/build_generation/smart_autobuild_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/build_generation_worst.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/price_selection.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/criteria_picker.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/value_slider.dart';
import 'package:provider/provider.dart';

class BuildGenerationSmart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<SmartAutobuildProvider>(
        create: (_) => SmartAutobuildProvider(),
        child: Scaffold(
            appBar: BuildGenerationAppBar(),
            body: Consumer<SmartAutobuildProvider>(
              builder: (_, state, __) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SoftContainer(
                      margin: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CriteriaPickerRow(
                              parameters: state.computerParams,
                              text: "Best Criteria:",
                              selected: state.bestCriteria,
                              onTap: state.setBestCritera),
                          SizedBox(height: 8),
                          CriteriaPickerRow(
                              parameters: state.computerParams,
                              text: "Worst Criteria:",
                              selected: state.worstCriteria,
                              onTap: state.setWorstCritera)
                        ],
                      ),
                    ),
                    Expanded(
                      child: SoftContainer(
                          margin: const EdgeInsets.only(left: 8, top: 2, bottom: 4, right: 8),
                          child: SoftListView([
                            Column(
                                children: state.criterias
                                    .map(
                                      (e) => ValueSlider(
                                        value: e.value.toDouble(),
                                        name: e.name,
                                        sliderMax: 100,
                                        sliderMin: 10,
                                        showDivider: state.criterias.first != e,
                                        onChanged: (double value) =>
                                            state.setCriteriaValue(e.criteria, value.toInt()),
                                      ),
                                    )
                                    .toList()),
                          ], null)),
                    ),
                    ActionButton(
                      title: "Next",
                      disabled: state.isDisabled,
                      onTap: () {
                        Navigator.of(context).push(
                            FadeRoute(page: PriceSelection(weights: state.generateWeights())));
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
