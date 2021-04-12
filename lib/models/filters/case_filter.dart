import 'package:pc_builder/models/sort_order.dart';

class CaseFilter {
  double selectedPriceMin;
  double selectedPriceMax;

  bool allSizes;
  List<String> sizes;

  bool allSidePanels;
  List<String> sidePanels;

  CaseSort sort;
  SortOrder order;

  CaseFilter(
      {this.selectedPriceMin,
      this.selectedPriceMax,
      this.sort,
      this.order,
      this.allSizes,
      this.sidePanels,
      this.sizes,
      this.allSidePanels});

  CaseFilter get copy => CaseFilter(
      selectedPriceMin: this.selectedPriceMin,
      selectedPriceMax: this.selectedPriceMax,
      sort: this.sort,
      order: this.order,
      sidePanels: this.sidePanels,
      allSidePanels: this.allSidePanels,
      allSizes: this.allSizes,
      sizes: this.sizes);

  static bool areEquel(CaseFilter filter1, CaseFilter filter2) {
    return filter1.selectedPriceMin == filter2.selectedPriceMin &&
        filter1.selectedPriceMax == filter2.selectedPriceMax &&
        filter1.allSidePanels == filter2.allSidePanels &&
        filter1.allSizes == filter2.allSizes &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        listsEquel(filter1.sizes, filter2.sizes) &&
        listsEquel(filter1.sidePanels, filter2.sidePanels);
  }

  static bool listsEquel(List<String> list1, List<String> list2) {
    if (list1.length == list2.length) {
      for (var e in list1) {
        var contains = list2.contains(e);
        if (!contains) return false;
      }

      return true;
    } else
      return false;
  }
}

enum CaseSort { none, price }
