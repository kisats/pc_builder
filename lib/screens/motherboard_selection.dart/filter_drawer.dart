import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_selection/filter/filter_appbar.dart';
import 'package:pc_builder/components/component_selection/filter/filter_bottom_buttons.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_filter_provider.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_provider.dart';
import 'package:pc_builder/screens/cpu_selection.dart/screen_components/cpu_filters.dart';
import 'package:provider/provider.dart';

class SelectionEndDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SoftContainer(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.2,
      shadows: [],
      shadowColor: theme.textTheme.headline1.color.withOpacity(0.7),
      borderRadiusGeom:
          BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      child: ClipRRect(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          child: Scaffold(
              appBar: FilterAppBar(),
              body: ShaderMask(
                shaderCallback: (Rect rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                    stops: [0.0, 0.03, 0.97, 1.0],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: CpuFilters(),
              ),
              bottomNavigationBar: Consumer<CPUSelectionFilterProvider>(
                  builder: (__, state, _) => FilterBottomButtons(
                        onApply: () {
                          state.applyFilter();
                          Provider.of<CPUSelectionProvider>(context, listen: false)
                              .applyFilter(state.filter);
                          Navigator.of(context).pop();
                        },
                        onClear: () {
                          state.clearFilter();
                          Provider.of<CPUSelectionProvider>(context, listen: false)
                              .applyFilter(null);
                        },
                        disabledApply: !state.hasChanged,
                        disabledClear: !state.canClear,
                      )))),
    );
  }
}
