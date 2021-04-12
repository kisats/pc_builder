import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:pc_builder/components/component_selection/selection_inner_drawer.dart';
import 'package:pc_builder/components/selection_appbar.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:provider/provider.dart';

import 'filter/filter_drawer.dart';

class ComponentSelection extends StatelessWidget {
  final Widget filters;
  final Widget Function(dynamic) componentCardBuilder;
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  ComponentSelection({Key key, this.filters, this.componentCardBuilder}) : super(key: key);

  void _toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.end);
  }

  @override
  Widget build(BuildContext context) {
    return SelectionInnerDrawer(
        innerDrawerKey: _innerDrawerKey,
        drawer: FilterDrawer(mainFilter: filters),
        scaffold: Scaffold(
          appBar: SelectionAppbar(
            toggleFilter: _toggle,
          ),
          body: Consumer<SelectionProvider>(builder: (_, state, __) {
            if (state.isLoading)
              return CircularProgressIndicator();
            else {
              var filterState = Provider.of<FilterProvider>(_, listen: false);
              if (!filterState.canBeOpened)
                Future.delayed(Duration(milliseconds: 50), () {
                  filterState.generateFilter(state.components);
                });

              return SoftListView.builder((_, index) => componentCardBuilder(state.filtered[index]),
                  state.filtered.length, state.scroll);
            }
          }),
        ));
  }
}
