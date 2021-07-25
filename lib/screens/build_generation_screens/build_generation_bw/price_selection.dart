import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/components/soft_range_slider.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/algorithm_selection_provider.dart';
import 'package:pc_builder/providers/build_generation/build_generator_provider.dart';
import 'package:pc_builder/providers/build_generation/bw_autobuild_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/build_generation_process.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:provider/provider.dart';

class PriceSelection extends StatefulWidget {
  final BuildWeights weights;

  const PriceSelection({Key key, this.weights}) : super(key: key);

  @override
  _PriceSelectionState createState() => _PriceSelectionState();
}

class _PriceSelectionState extends State<PriceSelection> {
  double maxPrice;

  @override
  void initState() {
    maxPrice = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: BuildGenerationAppBar(),
      body: Consumer<BWAutoBuildProvider>(
        builder: (_, state, __) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SoftContainer(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Select maximal computer build cost",
                        style: theme.textTheme.headline2.copyWith(fontWeight: FontWeight.w500)),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SoftSlider(
                        min: 0,
                        max: 10000,
                        handlerWidth: 60,
                        value: maxPrice,
                        suffix: "€",
                        onChanged: (_, start, end) {
                          setState(() {
                            maxPrice = start;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ActionButton(
                title: "Generate",
                disabled: maxPrice == 0 || maxPrice == null,
                onTap: () {
                  var decisionAlgorithm = Provider.of<AlgorithmSelectionProvider>(context, listen: false).selectedDecisionAlgorithm;
                  var buildGenerator = Provider.of<BuildGeneratorProvider>(context, listen: false);
                  if (decisionAlgorithm == DecisionMakingAlgorithms.topsis)
                    buildGenerator.generateBuildsTOPSIS(widget.weights, maxPrice);
                  else if (decisionAlgorithm == DecisionMakingAlgorithms.vikor)
                    buildGenerator.generateBuildsVIKOR(widget.weights, maxPrice);
                  else
                    buildGenerator.generateBuildsWSM(widget.weights, maxPrice);

                  Navigator.of(context).push(FadeRoute(page: BuildGenerationProcess()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
