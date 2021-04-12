import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/filters/case_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class CaseSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<Case> filteredList;
  TextEditingController textController;
  CaseFilter filter;
  ScrollController scroll;
  FocusNode focus;

  bool isLoading;

  List get components => db.caseList;
  List get filtered => filteredList;

  CaseSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.caseList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadCase();
      isLoading = false;
    }
    filteredList = db.caseList;
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
    filteredList = db.caseList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) => e.price >= filter.selectedPriceMin && e.price <= filter.selectedPriceMax)
          .toList();
      if (!filter.allSizes) filteredList.removeWhere((e) => !filter.sizes.contains(e.type));
      if (!filter.allSidePanels)
        filteredList.removeWhere((e) => !filter.sidePanels.contains(e.sidePanel));
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != CaseSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(Case a, Case b) {
    switch (filter.sort) {
      case CaseSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      default:
        return -1;
    }
  }
}
