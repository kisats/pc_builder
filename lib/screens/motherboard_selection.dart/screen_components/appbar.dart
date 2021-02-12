import 'package:flutter/material.dart';
import 'package:pc_builder/components/selection_appbar.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_filter_provider.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_provider.dart';
import 'package:provider/provider.dart';

class MotherboardSelectionAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    /* var theme = Theme.of(context);
    return Consumer<MotherboardSelectionProvider>(
      builder: (_, state, __) => Consumer<MotherboardSelectionFilterProvider>(
        builder: (_, filterState, __) => SelectionAppbar(
          filterIconColor: filterState.filter != null
              ? filterState.canClear && filterState.wasApplied
                  ? theme.textTheme.headline1.color
                  : theme.iconTheme.color
              : theme.iconTheme.color.withOpacity(0.5),
          controller: state.textController,
          focus: state.focus,
          canOpenFilter: filterState.filter != null,
        ),
      ),
    ); */
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}