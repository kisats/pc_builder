import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/providers/storage/storage_filter_provider.dart';
import 'package:pc_builder/providers/storage/storage_selection_provider.dart';
import 'package:pc_builder/screens/storage_selection/screen_components/filters.dart';
import 'package:pc_builder/screens/storage_selection/screen_components/storage_card.dart';
import 'package:provider/provider.dart';

class StorageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => StorageSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => StorageFilterProvider()),
      ],
      child: ComponentSelection(
        filters: StorageSelectionFilters(),
        componentCardBuilder: (component) => StorageCard(
          ssd: component,
        ),
      ),
    );
  }
}
