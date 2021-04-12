import 'package:flutter/material.dart';
import 'package:pc_builder/screens/case_selection/screen_components/case_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/case/case_filter_provider.dart';
import 'package:pc_builder/providers/case/case_selection_provider.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/case_selection/screen_components/filters.dart';
import 'package:provider/provider.dart';

class CaseSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => CaseSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => CaseFilterProvider()),
      ],
      child: ComponentSelection(
        filters: CaseSelectionFilters(),
        componentCardBuilder: (component) => CaseCard(
          model: component,
        ),
      ),
    );
  }
}