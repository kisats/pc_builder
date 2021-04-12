import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/providers/build_generation/autobuild_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/lianear_loading.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/param_weight_row.dart';
import 'package:pc_builder/screens/build_generation_screens/generated_builds/generated_builds.dart';
import 'package:provider/provider.dart';

class BuildGenerationProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: BuildGenerationAppBar(),
      body: Consumer<AutoBuildProvider>(
        builder: (_, state, __) {
          var maxWeight = state.getMaxWeight();
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SoftContainer(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          child: state.loading != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("Parameter weights:",
                                          style: theme.textTheme.headline1),
                                    ),
                                    WeightRow(
                                        name: "Price",
                                        weight: state.weights.price,
                                        value: state.weights.price / maxWeight),
                                    WeightRow(
                                        name: "Gaming",
                                        weight: state.weights.gaming,
                                        value: state.weights.gaming / maxWeight),
                                    WeightRow(
                                        name: "Content Creation",
                                        weight: state.weights.contentCreation,
                                        value: state.weights.contentCreation / maxWeight),
                                    WeightRow(
                                        name: "Multitasking",
                                        weight: state.weights.multitasking,
                                        value: state.weights.multitasking / maxWeight),
                                    WeightRow(
                                        name: "Storage",
                                        weight: state.weights.storage,
                                        value: state.weights.storage / maxWeight),
                                    WeightRow(
                                        name: "Consumption",
                                        weight: state.weights.consumption,
                                        value: state.weights.consumption / maxWeight),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Inconsistency ratio: ${state.weights.constant.toStringAsFixed(3)}",
                                        style: theme.textTheme.headline2.copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Calculating weights", style: theme.textTheme.headline1),
                                    SoftLinearLoading()
                                  ],
                                ),
                        ),
                        state.loading != null
                            ? SoftContainer(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(12),
                                child: state.loading != LoadingProcess.countedWeights &&
                                        state.loading != LoadingProcess.orderedParts
                                    ? Row(mainAxisSize: MainAxisSize.max, children: [
                                        Icon(
                                          FontAwesomeIcons.check,
                                          color: theme.toggleableActiveColor,
                                        ),
                                        SizedBox(width: 12),
                                        Text("Generated ${state.buildCount} builds",
                                            style: theme.textTheme.headline1)
                                      ])
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Generating Builds (Might take some time)",
                                              style: theme.textTheme.headline1),
                                          SizedBox(height: 8),
                                          SoftLinearLoading(
                                            value: state.generationProgress,
                                          )
                                        ],
                                      ))
                            : Container(),
                        state.loading != LoadingProcess.countedWeights &&
                                state.loading != null &&
                                state.loading != LoadingProcess.orderedParts
                            ? SoftContainer(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(12),
                                child: state.loading != LoadingProcess.generatedBuilds
                                    ? Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.check,
                                            color: theme.toggleableActiveColor,
                                          ),
                                          SizedBox(width: 12),
                                          Text("Build Selection Finished",
                                              style: theme.textTheme.headline1),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Selecting best builds",
                                              style: theme.textTheme.headline1),
                                          SizedBox(height: 8),
                                          SoftLinearLoading()
                                        ],
                                      ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
                ActionButton(
                  title: "Watch Builds",
                  disabled: state.loading != LoadingProcess.selectedBest,
                  onTap: () {
                    Navigator.of(context).push(FadeRoute(
                        page: GeneratedBuildsScreen(
                      builds: state.bestBuilds,
                    )));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
