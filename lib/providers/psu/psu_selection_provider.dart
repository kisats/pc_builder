import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/psu_filter.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class PSUSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<PowerSupply> filteredList;
  TextEditingController textController;
  ScrollController scroll;
  PSUFilter filter;
  FocusNode focus;

  bool isLoading;

  List get components => db.powerSupplyList;
  List get filtered => filteredList;

  PSUSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.powerSupplyList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadPowerSupply();
      isLoading = false;
    }
    filteredList = db.powerSupplyList.toList();
    notifyListeners();
  }

  search() {
    filterList();
    notifyListeners();
    moveToStart();
  }

  applyFilter(dynamic filter) {
    this.filter = filter;
    filterList();
    notifyListeners();
    moveToStart();
  }

  moveToStart() {
    if (scroll.offset > 0) scroll.jumpTo(0);
  }

  filterList() {
    filteredList = db.powerSupplyList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) => e.price >= filter.selectedMinPrice && e.price <= filter.selectedMaxPrice)
          .where((e) => e.wattage >= filter.selectedMinPower && e.wattage <= filter.selectedMaxPower)
          .toList();
      if (!filter.allEfficiency) filteredList.removeWhere((e) => !filter.efficiency.contains(e.efficiency));
      if (!filter.allFormFactors) filteredList.removeWhere((e) => !filter.formFactors.contains(e.formFactor));
    }

    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != PSUSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(PowerSupply a, PowerSupply b) {
    switch (filter.sort) {
      case PSUSort.wattage:
        return filter.order == SortOrder.descending
            ? b.wattage.compareTo(a.wattage)
            : a.wattage.compareTo(b.wattage);
      case PSUSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      default:
        return -1;
    }
  }
}
