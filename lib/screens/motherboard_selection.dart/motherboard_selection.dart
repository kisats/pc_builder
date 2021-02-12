import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_filter_provider.dart';
import 'package:pc_builder/providers/motherboard/motherboard_selection_provider.dart';
import 'package:pc_builder/screens/motherboard_selection.dart/screen_components/appbar.dart';
import 'package:provider/provider.dart';

class MotherboardSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* return MultiProvider(
      providers: [
        ChangeNotifierProvider<MotherboardSelectionProvider>(
          create: (_) => MotherboardSelectionProvider(FireStore())..unfilteredList(),
        ),
        ChangeNotifierProvider<MotherboardSelectionFilterProvider>(
            create: (_) => MotherboardSelectionFilterProvider()),
      ],
      child: Scaffold(
        appBar: MotherboardSelectionAppbar(),
        endDrawer: SelectionEndDrawer(),
        body: Consumer<CPUSelectionProvider>(builder: (_, state, __) {
          if (state.isLoading)
            return CircularProgressIndicator();
          else {
            if (Provider.of<CPUSelectionFilterProvider>(_, listen: false).filter == null)
              Future.delayed(Duration(milliseconds: 50), () {
                Provider.of<CPUSelectionFilterProvider>(_, listen: false)
                    .generateFilter(state.db.cpuList);
              });

            return SoftListView.builder(
              (_, index) => CPUCard(
                cpu: state.filteredList[index],
              ),
              state.filteredList.length,
            );
          }
        }),
      ),
    ); */
    return null;
  }
}
