import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/best_criteria_selection_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/build_generation_worst.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/criteria_picker.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/value_slider.dart';
import 'package:provider/provider.dart';

class BuildGenerationBestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<BestCriteriaSelectionProvider>(
        create: (_) =>
            BestCriteriaSelectionProvider(Provider.of<BWAutoBuildProvider>(context, listen: false)),
        child: Scaffold(
          appBar: BuildGenerationAppBar(),
          body: Consumer<BestCriteriaSelectionProvider>(
            builder: (_, state, __) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CriteriaPicker(
                      parameters: state.computerParams,
                      text: "Best Criteria:",
                      selected: state.bestCriteria,
                      onTap: state.setBestCritera),
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
                      Navigator.of(context).push(FadeRoute(page: BuildGenerationWorstScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
