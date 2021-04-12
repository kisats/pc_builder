import 'package:flutter/material.dart';
import 'package:pc_builder/screens/graphics_card_selection/screen_components/graphics_card_card.dart';
import 'package:pc_builder/components/component_selection/component_selection.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/graphics_card/graphics_card_filter_provider.dart';
import 'package:pc_builder/providers/graphics_card/graphics_card_selection_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:pc_builder/screens/graphics_card_selection/screen_components/filter.dart';
import 'package:provider/provider.dart';

class GraphicsCardSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectionProvider>(
          create: (_) => GraphicsCardSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<FilterProvider>(create: (_) => GraphicsCardFilterProvider()),
      ],
      child: ComponentSelection(
        filters: GraphicsCardFilters(),
        componentCardBuilder: (component) => GraphicCardCard(
          videoCard: component,
        ),
      ),
    );
  }
}
