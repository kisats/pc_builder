import 'package:flutter/material.dart';
import 'package:pc_builder/components/expansion_tile.dart';
import 'package:pc_builder/models/filters/psu_filter.dart';
import 'package:pc_builder/models/power_supply.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:queries/collections.dart';

class PSUFilterProvider extends ChangeNotifier implements FilterProvider {
  double minPrice;
  double maxPrice;

  int minWattage;
  int maxWattage;

  List<String> formFactors;
  List<String> efficiency;

  ExpansionController formFactorController = ExpansionController();
  ExpansionController efficiencyController = ExpansionController();

  PSUFilter filter;
  PSUFilter lastFilter;
  PSUFilter defoultFilter;

  bool wasApplied;

  dynamic get currentFilter => filter;
  bool get canBeOpened => filter != null;
  bool get hasChanged => !PSUFilter.areEquel(filter, lastFilter);
  bool get canClear => !PSUFilter.areEquel(filter, defoultFilter);

  generateFilter(List list) {
    var col = Collection(list as List<PowerSupply>);
    minPrice = col.min$1((e) => e.price).floorToDouble();
    maxPrice = col.max$1((e) => e.price).ceilToDouble();

    minWattage = col.min$1((e) => e.wattage);
    maxWattage = col.max$1((e) => e.wattage);

    formFactors = col.select((e) => e.formFactor).distinct().where((e) => e != null && e != "").toList();
    efficiency = col.select((e) => e.efficiency).distinct().where((e) => e != null && e != "").toList();
    formFactors.sort();
    efficiency.sort();

    filter = PSUFilter(
        allEfficiency: true,
        allFormFactors: true,
        efficiency: [],
        formFactors: [],
        selectedMinPower: minWattage,
        selectedMaxPower: maxWattage,
        selectedMaxPrice: maxPrice,
        selectedMinPrice: minPrice,
        sort: PSUSort.none,
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
    filter.selectedMinPrice = start >= minPrice ? start : minPrice;
    filter.selectedMaxPrice = end <= maxPrice ? end : maxPrice;
    notifyListeners();
  }

  setWattage(int start, int end) {
    filter.selectedMinPower = start;
    filter.selectedMaxPower = end;
    notifyListeners();
  }

  setAllFormFactors(bool value) {
    if (value)
      formFactorController.collapse();
    else
      formFactorController.expand();

    filter.allFormFactors = value;
    notifyListeners();
  }

  setAllEfficiency(bool value) {
    if (value)
      efficiencyController.collapse();
    else
      efficiencyController.expand();

    filter.allEfficiency = value;
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

  addEffieciency(String effiency) {
    filter.efficiency.add(effiency);
    notifyListeners();
  }

  removeEffieciency(String effiency) {
    filter.efficiency.remove(effiency);
    notifyListeners();
  }

  applyFilter() {
    lastFilter = filter.copy;
    wasApplied = !PSUFilter.areEquel(filter, defoultFilter);
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
    if (sort == PSUSort.none)
      filter.order = SortOrder.none;
    else if (filter.order == SortOrder.none) filter.order = SortOrder.descending;
    notifyListeners();
  }

  setSortOrder() {
    filter.order = filter.order == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }
}
