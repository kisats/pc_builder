import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/motherboard_selection_filter.dart';
import 'package:pc_builder/models/motherboard.dart';

class MotherboardSelectionProvider extends ChangeNotifier {
  
  FireStore db;

  List<Motherboard> filteredList;
  TextEditingController textController;
  MotherboardSelectionFilter filter;
  FocusNode focus;

  bool isLoading;

  MotherboardSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
  }

  unfilteredList() async {
    if (db.cpuList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadMotherboards();
      isLoading = false;
    }
    filteredList = db.motherboardList;
    notifyListeners();
  }

  search() {
    filterList();
    notifyListeners();
  }

  filterList() {
    /* if (filter != null) {
      filteredList = Collection(db.cpuList)
          .where((e) => e.cores >= filter.selectedMinCores && e.cores <= filter.selectedMaxCores)
          .where((e) => e.speed >= filter.selectedMinClock && e.speed <= filter.selectedMaxClock)
          .where((e) => e.price >= filter.selectedMinPrice && e.price <= filter.selectedMaxPrice)
          .where((e) =>
              e.consumption >= filter.selectedMinConsumption &&
              e.consumption <= filter.selectedMaxConsumption)
          .toList();
      if (!filter.showAmd) filteredList.removeWhere((e) => e.name.toLowerCase().contains("amd"));
      if (!filter.showIntel)
        filteredList.removeWhere((e) => e.name.toLowerCase().contains("intel"));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != CPUSort.none) {
      filteredList.sort(sort);
    } */
  }

  /* int sort(Cpu a, Cpu b) {
    switch (filter.sort) {
      case CPUSort.cores:
        return filter.order == SortOrder.descending
            ? b.cores.compareTo(a.cores)
            : a.cores.compareTo(b.cores);
      case CPUSort.clock:
        return filter.order == SortOrder.descending
            ? b.speed.compareTo(a.speed)
            : a.speed.compareTo(b.speed);
      case CPUSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      case CPUSort.consumption:
        return filter.order == SortOrder.descending
            ? b.consumption.compareTo(a.consumption)
            : a.consumption.compareTo(b.consumption);
      default:
        return -1;
    }
  } */

}