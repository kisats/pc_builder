import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/storage_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class StorageSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<SSD> filteredList;
  TextEditingController textController;
  ScrollController scroll;
  StorageFilter filter;
  FocusNode focus;

  bool isLoading;

  List get components => db.ssdList;
  List get filtered => filteredList;

  StorageSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.ssdList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadSSD();
      isLoading = false;
    }
    filteredList = db.ssdList.toList();
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
    filteredList = db.ssdList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) => e.capacity.floor() >= filter.selectedMinMemory && e.capacity.floor() <= filter.selectedMaxMemory)
          .where((e) => e.price >= filter.selectedMinPrice && e.price <= filter.selectedMaxPrice)
          .toList();
      if (!filter.nvme) filteredList.removeWhere((e) => e.isNVME);
      if (!filter.sata) filteredList.removeWhere((e) => !e.isNVME);
      if (!filter.allFormFactors)
        filteredList.removeWhere((e) => !filter.formFactors.contains(e.formFactor));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != StorageSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(SSD a, SSD b) {
    switch (filter.sort) {
      case StorageSort.memory:
        return filter.order == SortOrder.descending
            ? b.capacity.compareTo(a.capacity)
            : a.capacity.compareTo(b.capacity);
      case StorageSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      default:
        return -1;
    }
  }
}
