import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/filters/motherboard_selection_filter.dart';
import 'package:pc_builder/models/motherboard.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class MotherboardSelectionFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minRAMSlots;
  int maxRAMSlots;

  List<int> cores;

  List<String> sizes;
  List<String> sockets;

  MotherboardSelectionFilter filter;
  MotherboardSelectionFilter lastFilter;
  MotherboardSelectionFilter defoultFilter;

  ExpansionController sizeController = ExpansionController();
  ExpansionController socketController = ExpansionController();

  bool wasApplied;

  int coreStartValue;
  int coreEndValue;

  bool get canBeOpened => filter != null;
  get currentFilter => filter;
  bool get hasChanged => !MotherboardSelectionFilter.areEquel(filter, lastFilter);
  bool get canClear => !MotherboardSelectionFilter.areEquel(filter, defoultFilter);

  generateFilter(dynamic list) {
    var col = Collection(list as List<Motherboard>);

    minPrice = col.min$1((e) => e.price);
    maxPrice = col.max$1((e) => e.price);

    minRAMSlots = col.min$1((e) => e.ramSlots);
    maxRAMSlots = col.max$1((e) => e.ramSlots);

    sizes = col.select((e) => e.size).distinct().toList();
    sockets = col.select((e) => e.socket).distinct().toList();
    sockets.sort((a, b) => a.compareTo(b));

    filter = MotherboardSelectionFilter(
        selectedMinPrice: minPrice,
        selectedMaxPrice: maxPrice,
        ramSlotsMin: minRAMSlots,
        ramSlotsMax: maxRAMSlots,
        size: [],
        sockets: [],
        sort: MotherboardSort.none,
        order: SortOrder.none,
        allSizes: true,
        allSockets: true);

    wasApplied = false;

    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy;
    wasApplied = !MotherboardSelectionFilter.areEquel(filter, defoultFilter);
    notifyListeners();
  }

  clearFilter() {
    if (!filter.allSizes) sizeController.collapse();
    if (!filter.allSockets) socketController.collapse();
    filter = defoultFilter.copy;
    lastFilter = defoultFilter.copy;
    wasApplied = false;
    notifyListeners();
  }

  @override
  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }

  double getPriceValue(double price) {
    var valueblePrice = maxPrice / 1.2;

    if (price > valueblePrice) {
      return valueblePrice + ((price - valueblePrice) / 10) + 1;
    } else {
      return price;
    }
  }

  double getPriceFromValue(double value) {
    var valueblePrice = maxPrice / 1.2;

    if (value > valueblePrice) {
      return valueblePrice + ((value - valueblePrice) * 10);
    } else {
      return value;
    }
  }

  setSort(sort) {
    filter.sort = sort;
    if (sort == MotherboardSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setPrice(double start, double end) {
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setRAMSlots(int start, int end) {
    filter.ramSlotsMin = start;
    filter.ramSlotsMax = end;
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

  setAllSockets(bool value) {
    if (value)
      socketController.collapse();
    else
      socketController.expand();

    filter.allSockets = value;
    notifyListeners();
  }

  addSize(String size) {
    filter.size.add(size);
    notifyListeners();
  }

  removeSize(String size) {
    filter.size.remove(size);
    notifyListeners();
  }

  addSocket(String socket) {
    filter.sockets.add(socket);
    notifyListeners();
  }

  removeSocket(String socket) {
    filter.sockets.remove(socket);
    notifyListeners();
  }
}
