import 'package:flutter/material.dart';
import 'package:pc_builder/screens/psu_selection/screen_components/psu_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/psu/psu_filter_provider.dart';
import 'package:pc_builder/providers/psu/psu_selection_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/psu_selection/screen_components/filters.dart';
import 'package:provider/provider.dart';

class PSUSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => PSUSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => PSUFilterProvider()),
      ],
      child: ComponentSelection(
        filters: PSUSelectionFilters(),
        componentCardBuilder: (component) => PSUCard(
          psu: component,
        ),
      ),
    );
  }
}
