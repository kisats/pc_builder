import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/filters/cpu_selection_filter.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:queries/collections.dart';

class CPUSelectionProvider extends SelectionProvider{
  FireStore db;

  List<Cpu> filteredList;
  TextEditingController textController;
  CPUSelectionFilter filter;
  FocusNode focus;

  bool isLoading;

  List get components => db.cpuList;
  List get filtered => filteredList;

  CPUSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
  }

  unfilteredList() async {
    if (db.cpuList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadCpus();
      isLoading = false;
    }
    filteredList = db.cpuList.toList();
    notifyListeners();
  }

  search() {
    filterList();
    notifyListeners();
  }

  applyFilter(dynamic filter) {
    this.filter = filter;
    filterList();
    notifyListeners();
  }

  filterList() {
    filteredList = db.cpuList.toList();
    if (filter != null) {
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
    }


  }

  int sort(Cpu a, Cpu b) {
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
  }
}
