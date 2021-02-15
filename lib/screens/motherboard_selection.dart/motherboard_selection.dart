import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_cards/motherboard_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_filter_provider.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/motherboard_selection.dart/screen_components/filters.dart';
import 'package:provider/provider.dart';

class MotherboardSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => MotherboardSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => MotherboardSelectionFilterProvider()),
      ],
      child: ComponentSelection(
        filters: MotherboardFilters(),
        componentCardBuilder: (component) => MotherboardCard(
          mb: component,
        ),
      ),
    );
  }
}
