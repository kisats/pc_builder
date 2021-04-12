import 'package:flutter/material.dart';
import 'package:pc_builder/screens/cooler_selection/screen_components/cooler_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/cooler/cooler_filter_provider.dart';
import 'package:pc_builder/providers/cooler/cooler_selection_provider.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/cooler_selection/screen_components/filters.dart';
import 'package:provider/provider.dart';

class CoolerSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => CoolerSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => CoolerFilterProvider()),
      ],
      child: ComponentSelection(
        filters: CoolerSelectionFilters(),
        componentCardBuilder: (component) => CoolerCard(
          cooler: component,
        ),
      ),
    );
  }
}