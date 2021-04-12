import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/providers/build_generation/best_criteria_selection_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/build_generation_worst.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/criteria_picker.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation/screen_components/value_slider.dart';
import 'package:pc_builder/screens/build_generation_screens/generated_builds/generated_builds.dart';
import 'package:provider/provider.dart';

class BuildGenerationBestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider<BestCriteriaSelectionProvider>(
        create: (_) =>
            BestCriteriaSelectionProvider(Provider.of<AutoBuildProvider>(context, listen: false)),
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
                        margin: const EdgeInsets.all(8),
                        child: SoftListView([
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select other values compared to Best criteria",
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
                                            text: " - much less important",
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
                    onTap: () async {
                      //var builds = await state.getBuilds();
                      /*  Navigator.of(context).push(FadeRoute(
                          page: GeneratedBuildsScreen(
                        builds: builds,
                      ))); */
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
