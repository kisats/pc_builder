import 'package:flutter/material.dart';
import 'package:pc_builder/firestore.dart';
import 'package:pc_builder/models/cooler.dart';
import 'package:pc_builder/models/filters/cooler_filter.dart';
import 'package:pc_builder/models/sort_order.dart';
import 'package:pc_builder/providers/selection_provider.dart';

class CoolerSelectionProvider extends ChangeNotifier implements SelectionProvider {
  FireStore db;

  List<Cooler> filteredList;
  TextEditingController textController;
  CoolerFilter filter;
  ScrollController scroll;
  FocusNode focus;

  bool isLoading;

  List get components => db.coolerList;
  List get filtered => filteredList;

  CoolerSelectionProvider(this.db) {
    isLoading = false;
    textController = TextEditingController();
    textController.addListener(search);
    focus = FocusNode();
    scroll = ScrollController();
  }

  unfilteredList() async {
    if (db.coolerList == null) {
      isLoading = true;
      notifyListeners();
      await db.loadCoolers();
      isLoading = false;
    }
    filteredList = db.coolerList;
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
    filteredList = db.coolerList.toList();
    if (filter != null) {
      filteredList = filteredList
          .where((e) => e.price >= filter.selectedPriceMin && e.price <= filter.selectedPriceMax)
          .where((e) =>
              ((e.minNoise != null && e.minNoise >= filter.noiseMin) ||
                  (e.minNoise == null && e.maxNoise != null && e.maxNoise >= filter.noiseMin)) &&
              ((e.maxNoise != null && e.maxNoise <= filter.noiseMax) ||
                  (e.maxNoise == null && e.minNoise != null && e.minNoise <= filter.noiseMax)))
          .toList();
      if (!filter.showWaterCooled) filteredList.removeWhere((e) => e.radiatorSize != null);
      if (!filter.showAirCooled) filteredList.removeWhere((e) => e.radiatorSize == null);
    }
    if (textController.text?.isNotEmpty != null)
      filteredList
          .removeWhere((e) => !e.name.toLowerCase().contains(textController.text.toLowerCase()));

    if (filter != null && filter.sort != CoolerSort.none) {
      filteredList.sort(sort);
    }
  }

  int sort(Cooler a, Cooler b) {
    switch (filter.sort) {
      case CoolerSort.noise:
        return filter.order == SortOrder.descending
            ? b.maxNoise == null ? -1 : a.maxNoise == null ? 1 : b.maxNoise.compareTo(a.maxNoise)
            : a.minNoise == null ? -1 : b.minNoise == null ? 1 : a.minNoise.compareTo(b.minNoise);
      case CoolerSort.rpm:
        return filter.order == SortOrder.descending
            ? (b.maxRPM ?? 0).compareTo(a.maxRPM ?? 0)
            : (a.minRPM ?? 0).compareTo(b.minRPM ?? 0);
      case CoolerSort.price:
        return filter.order == SortOrder.descending
            ? b.price.compareTo(a.price)
            : a.price.compareTo(b.price);
      default:
        return -1;
    }
  }
}
