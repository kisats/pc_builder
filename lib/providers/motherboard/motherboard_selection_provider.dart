import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/filters/motherboard_selection_filter.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:queries/collections.dart';

class MotherboardSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<Motherboard> filteredList;
  TextEditingController textController;
  MotherboardSelectionFilter filter;
  ScrollController scroll;
  FocusNode focus;

  bool isLoading;

  List get components => db.motherboardList;

  List get filtered => filteredList;

  MotherboardSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (components == null) {
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
    moveToStart();
  }

  applyFilter(filter) {
    this.filter = filter;
    filterList();
    notifyListeners();
    moveToStart();
  }

  moveToStart(){
    if(scroll.offset > 0)
    scroll.jumpTo(0);
  }

  filterList() {
    filteredList = db.motherboardList.toList();
    if (filter != null) {
      filteredList = Collection(filteredList)
          .where((e) => e.price >= filter.selectedMinPrice && e.price <= filter.selectedMaxPrice)
          .where((e) => e.ramSlots >= filter.ramSlotsMin && e.ramSlots <= filter.ramSlotsMax)
          .toList();
      if (!filter.allSizes) filteredList.removeWhere((e) => !filter.size.contains(e.size));
      if (!filter.allSockets) filteredList.removeWhere((e) => !filter.sockets.contains(e.socket));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != MotherboardSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(Motherboard a, Motherboard b) {
    return filter.order == SortOrder.descending
        ? b.price.compareTo(a.price)
        : a.price.compareTo(b.price);
  }
}
