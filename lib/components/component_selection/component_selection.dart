import 'package:flutter/material.dart';
import 'package:pc_builder/components/selection_appbar.dart';
import 'package:pc_builder/components/soft_list_view.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:provider/provider.dart';

import 'filter/filter_drawer.dart';

class ComponentSelection extends StatelessWidget {
  final Widget filters;
  final Widget Function(dynamic) componentCardBuilder;

  const ComponentSelection({Key key, this.filters, this.componentCardBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectionAppbar(),
      endDrawer: FilterDrawer(mainFilter: filters),
      body: Consumer<SelectionProvider>(builder: (_, state, __) {
        if (state.isLoading)
          return CircularProgressIndicator();
        else {
          var filterState = Provider.of<FilterProvider>(_, listen: false);
          if (!filterState.canBeOpened)
            Future.delayed(Duration(milliseconds: 50), () {
              filterState.generateFilter(state.components);
            });

          return SoftListView.builder(
            (_, index) => componentCardBuilder(state.filtered[index]),
            state.filtered.length,
          );
        }
      }),
    );
  }
}
