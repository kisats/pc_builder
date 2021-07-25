import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/worst_criteria_selection_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/price_selection.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/criteria_picker.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/value_slider.dart';
import 'package:provider/provider.dart';

class BuildGenerationWorstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<WorstCriteriaSelectionProvider>(
        create: (_) => WorstCriteriaSelectionProvider(
            Provider.of<BWAutoBuildProvider>(context, listen: false)),
        child: Scaffold(
          appBar: BuildGenerationAppBar(),
          body: Consumer<WorstCriteriaSelectionProvider>(
            builder: (_, state, __) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CriteriaPicker(
                      parameters: state.computerParams,
                      text: "Worst Criteria:",
                      selected: state.worstCriteria,
                      onTap: state.setWorstCritera),
                  Expanded(
                    child: SoftContainer(
                        margin: const EdgeInsets.only(left: 8, top: 2, bottom: 4, right: 8),
                        child: SoftListView([
                          Column(
                              children: state.criterias
                                  .map(
                                    (e) => ValueSlider(
                                      showDivider: state.criterias.first != e,
                                      value: e.value.toDouble(),
                                      name: e.name,
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
                      state.submit();
                      var weights = Provider.of<BWAutoBuildProvider>(context, listen: false)
                          .generateWeights();
                      Navigator.of(context).push(FadeRoute(page: PriceSelection(weights: weights)));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
