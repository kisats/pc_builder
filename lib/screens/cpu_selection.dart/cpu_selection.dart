import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/components/cpu_card.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_filter_provider.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_provider.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/cpu_selection.dart/screen_components/cpu_filters.dart';
import 'package:provider/provider.dart';

class CPUSelection extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => CPUSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => CPUSelectionFilterProvider()),
      ],
      child: ComponentSelection(
        filters: CpuFilters(),
        componentCardBuilder: (component) => CPUCard(
          cpu: component,
        ),
      ),
    );
  }
}
