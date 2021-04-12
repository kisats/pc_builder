import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/components/soft_range_slider.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/worst_criteria_selection_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/price_selection.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/criteria_picker.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/value_slider.dart';
import 'package:pc_builder/screens/build_generation_screens/generated_builds/generated_builds.dart';
import 'package:provider/provider.dart';

class BuildGenerationWorstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<WorstCriteriaSelectionProvider>(
        create: (_) =>
            WorstCriteriaSelectionProvider(Provider.of<AutoBuildProvider>(context, listen: false)),
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
                        margin: const EdgeInsets.all(8),
                        child: SoftListView([
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select other values compared to Worst criteria",
                                    style: theme.textTheme.headline2
                                        .copyWith(fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 6,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "9",
                                      style: theme.textTheme.headline1,
                                      children: [
                                        TextSpan(
                                            text: " - much more important",
                                            style: theme.textTheme.headline2
                                                .copyWith(fontWeight: FontWeight.w500))
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "1",
                                      style: theme.textTheme.headline1,
                                      children: [
                                        TextSpan(
                                            text: " - almost as important",
                                            style: theme.textTheme.headline2
                                                .copyWith(fontWeight: FontWeight.w500))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Column(
                              children: state.criterias
                                  .map(
                                    (e) => ValueSlider(
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
                      Navigator.of(context).push(FadeRoute(page: PriceSelection()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
