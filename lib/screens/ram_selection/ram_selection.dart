import 'package:flutter/material.dart';
import 'package:pc_builder/screens/ram_selection/screen_components/ram_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/ram/ram_selection_filter_provider.dart';
import 'package:pc_builder/providers/ram/ram_selection_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/ram_selection/screen_components/filter.dart';
import 'package:provider/provider.dart';

class RAMSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => RAMSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => RAMSelectionFilterProvider()),
      ],
      child: ComponentSelection(
        filters: RAMSelectionFilters(),
        componentCardBuilder: (component) => RAMCard(
          ram: component,
        ),
      ),
    );
  }
}
