import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_button.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/algorithm_selection_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/algorithm_selection/screen_components/algorithm_buttons.dart';
import 'package:pc_builder/screens/build_generation_screens/algorithm_selection/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/build_generation_best.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_ranking/build_generation_ranking.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_smart/build_generation_smart.dart';
import 'package:provider/provider.dart';

class AlgorithmSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AlgorithmSelectionAppBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Consumer<AlgorithmSelectionProvider>(
            builder: (context, state, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
                        child: Text(
                          "Select Weightage algorithm",
                          style: theme.textTheme.headline2,
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          AlgorithmButton(
                            text: "Best Worst",
                            isSelected:
                                state.selectedWeightageAlgorithm == WeightageAlgorithms.bestWorst,
                            onTap: () =>
                                state.selectWeightageAlgorithm(WeightageAlgorithms.bestWorst),
                          ),
                          AlgorithmButton(
                            text: "Ranking",
                            isSelected:
                                state.selectedWeightageAlgorithm == WeightageAlgorithms.ranking,
                            onTap: () =>
                                state.selectWeightageAlgorithm(WeightageAlgorithms.ranking),
                          ),
                          AlgorithmButton(
                            text: "SMART",
                            isSelected:
                                state.selectedWeightageAlgorithm == WeightageAlgorithms.smart,
                            onTap: () => state.selectWeightageAlgorithm(WeightageAlgorithms.smart),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12, top: 30),
                        child: Text(
                          "Select Decision making algorithm",
                          style: theme.textTheme.headline2,
                        ),
                      ),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          AlgorithmButton(
                            text: "TOPSIS",
                            isSelected:
                                state.selectedDecisionAlgorithm == DecisionMakingAlgorithms.topsis,
                            onTap: () =>
                                state.selectDecisionAlgorithm(DecisionMakingAlgorithms.topsis),
                          ),
                          AlgorithmButton(
                            text: "WSM",
                            isSelected:
                                state.selectedDecisionAlgorithm == DecisionMakingAlgorithms.wsm,
                            onTap: () =>
                                state.selectDecisionAlgorithm(DecisionMakingAlgorithms.wsm),
                          ),
                          AlgorithmButton(
                            text: "VIKOR",
                            isSelected:
                                state.selectedDecisionAlgorithm == DecisionMakingAlgorithms.vikor,
                            onTap: () =>
                                state.selectDecisionAlgorithm(DecisionMakingAlgorithms.vikor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ActionButton(
                  title: "Generate",
                  disabled: false,
                  onTap: () {
                    if (state.selectedWeightageAlgorithm == WeightageAlgorithms.bestWorst)
                      Navigator.of(context).push(FadeRoute(page: BuildGenerationBestScreen()));
                    else if (state.selectedWeightageAlgorithm == WeightageAlgorithms.ranking)
                      Navigator.of(context).push(FadeRoute(page: BuildGenerationRanking()));
                    else
                      Navigator.of(context).push(FadeRoute(page: BuildGenerationSmart()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
