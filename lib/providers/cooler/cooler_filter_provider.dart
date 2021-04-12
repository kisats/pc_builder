import 'package:flutter/material.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/filters/cooler_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class CoolerFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minNoise;
  int maxNoise;

  CoolerFilter filter;
  CoolerFilter lastFilter;
  CoolerFilter defoultFilter;

  bool wasApplied;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => filter != lastFilter;
  bool get canClear => filter != defoultFilter;

  generateFilter(List list) {
    var col = Collection(list as List<Cooler>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    minNoise = col.min$1((e) => e.minNoise?.floor());
    maxNoise = col.max$1((e) => e.maxNoise?.ceil());

    filter = CoolerFilter(
        showAirCooled: true,
        showWaterCooled: true,
        noiseMax: maxNoise,
        noiseMin: minNoise,
        selectedPriceMax: maxPrice,
        selectedPriceMin: minPrice,
        sort: CoolerSort.none,
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

  setAirCooled(bool value) {
    filter.showAirCooled = value;
    notifyListeners();
  }

  setWaterCooled(bool value) {
    filter.showWaterCooled = value;
    notifyListeners();
  }

  setNoise(int start, int end) {
    filter.noiseMin = start;
    filter.noiseMax = end;
    notifyListeners();
  }

  setPrice(double start, double end) {
    filter.selectedPriceMin = start >= minPrice ? start : minPrice;
    filter.selectedPriceMax = end <= maxPrice ? end : maxPrice;
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
    wasApplied = false;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == CoolerSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
