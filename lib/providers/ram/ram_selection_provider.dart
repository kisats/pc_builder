import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/ram_filter.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class RAMSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<RAM> filteredList;
  TextEditingController textController;
  RAMFilter filter;
  ScrollController scroll;
  FocusNode focus;

  bool isLoading;

  List get components => db.ramList;
  List get filtered => filteredList;

  RAMSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.ramList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadRam();
      isLoading = false;
    }
    filteredList = db.ramList.toList();
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
    filteredList = db.ramList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) =>
              e.stickMemory != null &&
              e.stickMemory >= filter.selectedMinMemory &&
              e.stickMemory <= filter.selectedMaxMemory)
          .where((e) =>
              e.speed != null &&
              e.speed >= filter.selectedMinSpeed &&
              e.speed <= filter.selectedMaxSpeed)
          .where((e) =>
              e.price != null &&
              e.price >= filter.selectedMinPrice &&
              e.price <= filter.selectedMaxPrice)
          .where((e) =>
              e.voltage != null &&
              e.voltage >= filter.selectedMinVoltage &&
              e.voltage <= filter.selectedMaxVoltage)
          .toList();
      if (!filter.allMemoryTypes)
        filteredList.removeWhere((e) => !filter.memoryTypes.contains(e.memoryType));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != RAMSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(RAM a, RAM b) {
    switch (filter.sort) {
      case RAMSort.memory:
        return filter.order == SortOrder.descending
            ? b.stickMemory.compareTo(a.stickMemory)
            : a.stickMemory.compareTo(b.stickMemory);
      case RAMSort.speed:
        return filter.order == SortOrder.descending
            ? b.speed.compareTo(a.speed)
            : a.speed.compareTo(b.speed);
      case RAMSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      case RAMSort.voltage:
        return filter.order == SortOrder.descending
            ? b.voltage.compareTo(a.voltage)
            : a.voltage.compareTo(b.voltage);
      default:
        return -1;
    }
  }
}
