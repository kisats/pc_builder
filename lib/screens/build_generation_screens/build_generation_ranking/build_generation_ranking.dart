import 'package:flutter/material.dart';
import 'package:pc_builder/components/fade_route.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/models/autobuild.dart';
import 'package:pc_builder/providers/build_generation/ranking_autobuild_provider.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/price_selection.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/action_button.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_bw/screen_components/appbar.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_ranking/screen_components/drag_criteria.dart';
import 'package:pc_builder/screens/build_generation_screens/build_generation_ranking/screen_components/parameter_row.dart';
import 'package:provider/provider.dart';

class BuildGenerationRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: BuildGenerationAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Consumer<RankingAutoBuildProvider>(
          builder: (context, state, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SoftContainer(
                margin: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _draggable(state, ComputerParameter.price, context),
                    _draggable(state, ComputerParameter.gaming, context),
                    _draggable(state, ComputerParameter.contentCreation, context),
                    _draggable(state, ComputerParameter.multitasking, context),
                    _draggable(state, ComputerParameter.consumption, context),
                    _draggable(state, ComputerParameter.storage, context),
                  ],
                ),
              ),
              Expanded(
                child: SoftContainer(
                  margin: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 2),
                      ParameterRow(
                          icon: Icons.filter_1,
                          onAccept: state.setFirst,
                          selectedParam: state.firstParam),
                      Divider(height: 1),
                      ParameterRow(
                          icon: Icons.filter_2,
                          onAccept: state.setSecond,
                          selectedParam: state.secondParam),
                      Divider(height: 1),
                      ParameterRow(
                          icon: Icons.filter_3,
                          onAccept: state.setThird,
                          selectedParam: state.thirdParam),
                      Divider(height: 1),
                      ParameterRow(
                          icon: Icons.filter_4,
                          onAccept: state.setFourth,
                          selectedParam: state.fourthParam),
                      Divider(height: 1),
                      ParameterRow(
                          icon: Icons.filter_5,
                          onAccept: state.setFift,
                          selectedParam: state.fiftParam),
                      Divider(height: 1),
                      ParameterRow(
                          icon: Icons.filter_6,
                          onAccept: state.setSix,
                          selectedParam: state.sixParam),
                      SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              ActionButton(
                title: "Generate",
                disabled: !state.canGenerate,
                onTap: () {
                  Navigator.of(context)
                      .push(FadeRoute(page: PriceSelection(weights: state.countWeights())));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _draggable(RankingAutoBuildProvider state, ComputerParameter param, BuildContext context) {
    return state.isParamTaken(param) ? _takenDrag(param, context) : DragCriteria(param: param);
  }

  _takenDrag(ComputerParameter param, BuildContext context) {
    return Opacity(
        opacity: 0.5,
        child: SoftContainer(
          padding: const EdgeInsets.all(8),
          child: Text(
            mapComputerParameter(param),
            style: Theme.of(context).textTheme.headline1,
          ),
        ));
  }

  _dragRow(IconData icon, Function(ComputerParameter) onAccept, ComputerParameter selectedParam) {}
}
