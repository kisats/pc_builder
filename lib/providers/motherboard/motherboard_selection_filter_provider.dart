import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/filters/motherboard_selection_filter.dart';
import 'package:pc_builder/models/motherboard.dart';
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

  bool get hasChanged => filter != lastFilter;
  bool get canClear => filter != defoultFilter;

  generateFilter(dynamic list) {
    var col = Collection(list as List<Motherboard>);

    minPrice = col.min$1((e) => e.price);
    maxPrice = col.max$1((e) => e.price);

    minRAMSlots = col.min$1((e) => e.ramSlots);
    maxRAMSlots = col.max$1((e) => e.ramSlots);

    sizes = col.select((e) => e.size).distinct().toList();
    sockets = col.select((e) => e.socket).distinct().toList();

    filter = MotherboardSelectionFilter(
        selectedMinPrice: minPrice,
        selectedMaxPrice: maxPrice,
        ramSlotsMin: minRAMSlots,
        ramSlotsMax: maxRAMSlots,
        size: sizes,
        sockets: sockets,
        sort: MotherboardSort.none,
        order: SortOrder.none,
        allSizes: true,
        allSockets: true);

    wasApplied = false;

    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    notifyListeners();
  }

  @override
  applyFilter() {
    // TODO: implement applyFilter
    throw UnimplementedError();
  }

  @override
  clearFilter() {
    // TODO: implement clearFilter
    throw UnimplementedError();
  }

  @override
  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }

  double getPriceValue(double price) {
    var valueblePrice = maxPrice / 1.4;

    if (price > valueblePrice) {
      return valueblePrice + ((price - valueblePrice) / 10) + 1;
    } else {
      return price;
    }
  }

  double getPriceFromValue(double value) {
    var valueblePrice = maxPrice / 1.4;

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

  /* setIntel(bool value) {
    filter.showIntel = value;
    notifyListeners();
  }

  setAMD(bool value) {
    filter.showAmd = value;
    notifyListeners();
  }

  setCores(int start, int end) {
    filter.selectedMinCores = start;
    filter.selectedMaxCores = end;

    coreStartValue = getCoreCountPrecent(start);
    coreEndValue = getCoreCountPrecent(end);
    notifyListeners();
  }

  setClock(double start, double end) {
    filter.selectedMinClock = start;
    filter.selectedMaxClock = end;
    notifyListeners();
  }

  setPrice(double start, double end) {
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setConsumption(int start, int end) {
    filter.selectedMinConsumption = start;
    filter.selectedMaxConsumption = end;
    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy();
    wasApplied = filter != defoultFilter;
    notifyListeners();
  }

  clearFilter() {
    filter = defoultFilter.copy();
    notifyListeners();
  }

  setSort(sort) {
    filter.sort = sort;
    if (sort == CPUSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  } */
}
