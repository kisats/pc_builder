import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_selection/filter/filter_appbar.dart';
import 'package:pc_builder/components/component_selection/filter/filter_bottom_buttons.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatelessWidget {
  final Widget mainFilter;

  const FilterDrawer({Key key, this.mainFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SoftContainer(
      height: MediaQuery.of(context).size.height,
      shadows: [
        BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.4),
            offset: Offset(0.0, 2.0),
            blurRadius: 2,
            spreadRadius: 1),
      ],
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
                child: Consumer<FilterProvider>(
                    builder: (__, state, _) => state.canBeOpened ? mainFilter : Container()),
              ),
              bottomNavigationBar: Consumer<FilterProvider>(
                  builder: (__, state, _) => FilterBottomButtons(
                        onApply: () {
                          state.applyFilter();
                          Provider.of<SelectionProvider>(context, listen: false)
                              .applyFilter(state.currentFilter);
                          Navigator.of(context).pop();
                        },
                        onClear: () {
                          state.clearFilter();
                          Provider.of<SelectionProvider>(context, listen: false).applyFilter(null);
                        },
                        disabledApply: !state.hasChanged,
                        disabledClear: !state.canClear,
                      )))),
    );
  }
}
