import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/filters/graphics_card_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/models/video_card.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:darq/darq.dart';

class GraphicsCardFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minClock;
  int maxClock;

  int minConsumption;
  int maxConsumption;

  int maxMemory;
  int minMemory;

  List<String> memoryTypes;

  GraphicsCardFilter filter;
  GraphicsCardFilter lastFilter;
  GraphicsCardFilter defoultFilter;

  ExpansionController memoryTypeController = ExpansionController();

  bool wasApplied;

  int coreStartValue;
  int coreEndValue;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => !GraphicsCardFilter.areEquel(filter, lastFilter);
  bool get canClear => !GraphicsCardFilter.areEquel(filter, defoultFilter);

  generateFilter(List components) {
    var list = (components as List<VideoCard>);

    maxPrice = list.where((e) => e.price != null).select((e, _) => e.price).max();
    minPrice = list.where((e) => e.price != null).select((e, _) => e.price).min();
    maxClock = list.where((e) => e.clock != null).select((e, _) => e.clock).max();
    minClock = list.where((e) => e.clock != null).select((e, _) => e.clock).min();
    maxConsumption =
        list.where((e) => e.consumption != null).select((e, _) => e.consumption ?? 0).max();
    minConsumption =
        list.where((e) => e.consumption != null).select((e, _) => e.consumption ?? 0).min();

    maxMemory = list.where((e) => e.memory != null).select((e, _) => e.memory ?? 0).max();
    minMemory = list.where((e) => e.memory != null).select((e, _) => e.memory ?? 0).min();

    memoryTypes =
        list.where((e) => e.memoryType != null).select((e, _) => e.memoryType).distinct().toList();

    filter = GraphicsCardFilter(
        allMemoryTypes: true,
        selectedMaxPrice: maxPrice,
        selectedMinPrice: minPrice,
        selectedMaxClock: maxClock,
        selectedMinClock: minClock,
        selectedMaxConsumption: maxConsumption,
        selectedMinConsumption: minConsumption,
        selectedMaxMemory: maxMemory,
        selectedMinMemory: minMemory,
        sort: GraphicsCardSort.none,
        order: SortOrder.none,
        memoryTypes: []);
    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    wasApplied = false;
    notifyListeners();
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

  setPrice(double start, double end) {
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setMemory(int start, int end) {
    filter.selectedMinMemory = start;
    filter.selectedMaxMemory = end;
    notifyListeners();
  }

  setClock(int start, int end) {
    filter.selectedMinClock = start;
    filter.selectedMaxClock = end;
    notifyListeners();
  }

  setConsumption(int start, int end) {
    filter.selectedMinConsumption = start;
    filter.selectedMaxConsumption = end;
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
    wasApplied = !GraphicsCardFilter.areEquel(filter, defoultFilter);
    notifyListeners();
  }

  clearFilter() {
    if (!memoryTypeController.isClosed) memoryTypeController.collapse();
    filter = defoultFilter.copy;
    lastFilter = defoultFilter.copy;
    wasApplied = false;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == GraphicsCardSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
