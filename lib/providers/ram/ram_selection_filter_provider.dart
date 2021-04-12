import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/filters/ram_filter.dart';
import 'package:pc_builder/models/ram.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class RAMSelectionFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minMemory;
  int maxMemory;

  int minSpeed;
  int maxSpeed;

  double minVoltage;
  double maxVoltage;

  List<String> memoryTypes;
  bool allMemoryTypes;
  
  ExpansionController memoryTypeController = ExpansionController();

  RAMFilter filter;
  RAMFilter lastFilter;
  RAMFilter defoultFilter;

  bool wasApplied;

  int coreStartValue;
  int coreEndValue;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => !RAMFilter.areEquel(filter, lastFilter);
  bool get canClear => !RAMFilter.areEquel(filter, defoultFilter);

  generateFilter(List list) {
    var col = Collection(list as List<RAM>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    minMemory = col.min$1((e) => e.stickMemory);
    maxMemory = col.max$1((e) => e.stickMemory);

    minSpeed = col.min$1((e) => e.speed);
    maxSpeed = col.max$1((e) => e.speed);

    minVoltage = col.min$1((e) => e.voltage);
    maxVoltage = col.max$1((e) => e.voltage);

    memoryTypes = col.select((e) => e.memoryType).distinct().toList();
    memoryTypes.sort();

    filter = RAMFilter(
        allMemoryTypes: true,
        selectedMinMemory: minMemory,
        selectedMaxMemory: maxMemory,
        selectedMinPrice: minPrice,
        selectedMaxPrice: maxPrice,
        selectedMinSpeed: minSpeed,
        selectedMaxSpeed: maxSpeed,
        selectedMinVoltage: minVoltage,
        selectedMaxVoltage: maxVoltage,
        sort: RAMSort.none,
        order: SortOrder.none,
        memoryTypes: []);
    
    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    wasApplied = false;
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

  setMemory(int start, int end) {
    filter.selectedMinMemory = start;
    filter.selectedMaxMemory = end;
    notifyListeners();
  }

  setVoltage(double start, double end) {
    filter.selectedMinVoltage = start;
    filter.selectedMaxVoltage = end;
    notifyListeners();
  }

  setPrice(double start, double end) {
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setSpeed(int start, int end) {
    filter.selectedMinSpeed = start;
    filter.selectedMaxSpeed = end;
    notifyListeners();
  }

  setAllMemoryTypes(bool value) {
    if (value)
      memoryTypeController.collapse();
    else
      memoryTypeController.expand();

    filter.allMemoryTypes = value;
    notifyListeners();
  }

  addMemoryType(String memoryType) {
    filter.memoryTypes.add(memoryType);
    notifyListeners();
  }

  removeMemoryType(String memoryType) {
    filter.memoryTypes.remove(memoryType);
    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy;
    wasApplied = filter != defoultFilter;
    notifyListeners();
  }

  clearFilter() {
    filter = defoultFilter.copy;
    lastFilter = defoultFilter.copy;
    if(!memoryTypeController.isClosed) memoryTypeController.collapse();
    wasApplied = true;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == RAMSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
