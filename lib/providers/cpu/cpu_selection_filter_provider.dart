import 'package:flutter/material.dart';
import 'package:pc_builder/models/cpu.dart';
import 'package:pc_builder/models/filters/cpu_selection_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class CPUSelectionFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minCores;
  int maxCores;

  double minClock;
  double maxClock;

  int minConsumption;
  int maxConsumption;

  List<int> cores;

  CPUSelectionFilter filter;
  CPUSelectionFilter lastFilter;
  CPUSelectionFilter defoultFilter;

  bool wasApplied;

  int coreStartValue;
  int coreEndValue;
  
  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => filter != lastFilter;
  bool get canClear => filter != defoultFilter;

  generateFilter(List list) {
    var col = Collection(list as List<Cpu>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    minCores = col.min$1((e) => e.cores);
    maxCores = col.max$1((e) => e.cores);

    minClock = col.min$1((e) => e.speed);
    maxClock = col.max$1((e) => e.speed);

    minConsumption = col.min$1((e) => e.consumption);
    maxConsumption = col.max$1((e) => e.consumption);

    cores = col.select((e) => e.cores).distinct().toList();
    cores.sort();

    coreStartValue = getCoreCountPrecent(cores.first);
    coreEndValue = getCoreCountPrecent(cores.last);

    filter = CPUSelectionFilter(
        showAmd: true,
        showIntel: true,
        selectedMinCores: minCores,
        selectedMaxCores: maxCores,
        selectedMinClock: minClock,
        selectedMaxClock: maxClock,
        selectedMaxPrice: maxPrice,
        selectedMinPrice: minPrice,
        selectedMaxConsumption: maxConsumption,
        selectedMinConsumption: minConsumption,
        sort: CPUSort.none,
        order: SortOrder.none);
    lastFilter = filter.copy();
    defoultFilter = filter.copy();

    wasApplied = false;
    notifyListeners();
  }

  getCoreCountPrecent(int coreCount) {
    return (cores.indexOf(coreCount) / (cores.length - 1) * 100).toInt();
  }

  double getPriceValue(double price) {
    var valueblePrice = maxPrice / 4;

    if (price > valueblePrice) {
      return valueblePrice + ((price - valueblePrice) / 10) + 1;
    } else {
      return price;
    }
  }

  double getPriceFromValue(double value) {
    var valueblePrice = maxPrice / 4;

    if (value > valueblePrice) {
      return valueblePrice + ((value - valueblePrice) * 10);
    } else {
      return value;
    }
  }

  setIntel(bool value) {
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
    lastFilter = defoultFilter.copy();
    wasApplied = false;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == CPUSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
