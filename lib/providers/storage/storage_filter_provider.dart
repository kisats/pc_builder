import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/filters/storage_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/models/ssd.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class StorageFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minMemory;
  int maxMemory;

  List<String> formFactor;

  ExpansionController formFactorController = ExpansionController();

  StorageFilter filter;
  StorageFilter lastFilter;
  StorageFilter defoultFilter;

  bool wasApplied;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => !StorageFilter.areEquel(filter, lastFilter);
  bool get canClear => !StorageFilter.areEquel(filter, defoultFilter);

  generateFilter(List list) {
    var col = Collection(list as List<SSD>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    minMemory = col.min$1((e) => e.capacity.floor());
    maxMemory = col.max$1((e) => e.capacity.floor());

    formFactor = col.select((e) => e.formFactor).distinct().toList();
    formFactor.sort();

    filter = StorageFilter(
      allFormFactors: true,
      nvme: true,
      sata: true,
      selectedMinMemory: minMemory,
      selectedMaxMemory: maxMemory,
      selectedMinPrice: minPrice,
      selectedMaxPrice: maxPrice,
      formFactors: [],
      sort: StorageSort.none,
      order: SortOrder.none);

    lastFilter = filter.copy;
    defoultFilter = filter.copy;

    

    wasApplied = false;
    notifyListeners();
  }

  double getPriceValue(double price) {
    var valueblePrice = maxPrice / 2;

    if (price > valueblePrice) {
      return valueblePrice + ((price - valueblePrice) / 10) + 1;
    } else {
      return price;
    }
  }

  double getPriceFromValue(double value) {
    var valueblePrice = maxPrice / 2;

    if (value > valueblePrice) {
      return valueblePrice + ((value - valueblePrice) * 10);
    } else {
      return value;
    }
  }

  setNVMe(bool value) {
    filter.nvme = value;
    notifyListeners();
  }

  setSATA(bool value) {
    filter.sata = value;
    notifyListeners();
  }

  setMemory(int start, int end) {
    filter.selectedMinMemory = start;
    filter.selectedMaxMemory = end;
    notifyListeners();
  }

  setPrice(double start, double end) {
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setAllFormFactor(bool value) {
    if (value)
      formFactorController.collapse();
    else
      formFactorController.expand();

    filter.allFormFactors = value;
    notifyListeners();
  }

  addFormFactor(String formFactor) {
    filter.formFactors.add(formFactor);
    notifyListeners();
  }

  removeFormFactor(String formFactor) {
    filter.formFactors.remove(formFactor);
    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy;
    wasApplied = !StorageFilter.areEquel(filter, defoultFilter);
    notifyListeners();
  }

  clearFilter() {
    filter = defoultFilter.copy;
    lastFilter = defoultFilter.copy;
    wasApplied = true;
    notifyListeners();
  }

  setSort(dynamic sort) {
    filter.sort = sort;
    if (sort == StorageSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}