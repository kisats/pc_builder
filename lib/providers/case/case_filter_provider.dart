import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/case.dart';
import 'package:pc_builder/models/filters/case_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class CaseFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  List<String> sizes;
  List<String> panels;

  CaseFilter filter;
  CaseFilter lastFilter;
  CaseFilter defoultFilter;

  bool wasApplied;

  ExpansionController sizeController = ExpansionController();
  ExpansionController panelController = ExpansionController();

  int coreStartValue;
  int coreEndValue;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => !CaseFilter.areEquel(filter, lastFilter);
  bool get canClear => !CaseFilter.areEquel(filter, defoultFilter);

  generateFilter(List list) {
    var col = Collection(list as List<Case>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    sizes = col.select((e) => e.type).distinct().toList();
    panels = col.select((e) => e.sidePanel).distinct().toList();

    filter = CaseFilter(
        selectedPriceMax: maxPrice,
        selectedPriceMin: minPrice,
        allSidePanels: true,
        allSizes: true,
        sizes: [],
        sidePanels: [],
        sort: CaseSort.none,
        order: SortOrder.none);

    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    wasApplied = false;
    notifyListeners();
  }

  double getPriceValue(double price) {
    var valueblePrice = maxPrice / 1.1;

    if (price > valueblePrice) {
      return valueblePrice + ((price - valueblePrice) / 10) + 1;
    } else {
      return price;
    }
  }

  double getPriceFromValue(double value) {
    var valueblePrice = maxPrice / 1.1;

    if (value > valueblePrice) {
      return valueblePrice + ((value - valueblePrice) * 10);
    } else {
      return value;
    }
  }

  setPrice(double start, double end) {
    filter.selectedPriceMin = start >= minPrice ? start : minPrice;
    filter.selectedPriceMax = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setAllSizes(bool value) {
    if (value)
      sizeController.collapse();
    else
      sizeController.expand();

    filter.allSizes = value;
    notifyListeners();
  }

  setAllPanels(bool value) {
    if (value)
      panelController.collapse();
    else
      panelController.expand();

    filter.allSidePanels = value;
    notifyListeners();
  }

  addSize(String size) {
    filter.sizes.add(size);
    notifyListeners();
  }

  removeSize(String size) {
    filter.sizes.remove(size);
    notifyListeners();
  }

  addSidePanel(String socket) {
    filter.sidePanels.add(socket);
    notifyListeners();
  }

  removeSidePanel(String socket) {
    filter.sidePanels.remove(socket);
    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy;
    wasApplied = !CaseFilter.areEquel(filter, defoultFilter);
    notifyListeners();
  }

  clearFilter() {
    if (!filter.allSizes) sizeController.collapse();
    if (!filter.allSidePanels) panelController.collapse();
    filter = defoultFilter.copy;
    lastFilter = defoultFilter.copy;
    wasApplied = false;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == CaseSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
