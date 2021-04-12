import 'package:pc_builder/models/sort_order.dart';

class MotherboardSelectionFilter {
  double selectedMinPrice;
  double selectedMaxPrice;

  int ramSlotsMin;
  int ramSlotsMax;

  List<String> sockets;
  List<String> size;

  MotherboardSort sort;
  SortOrder order;

  bool allSizes;
  bool allSockets;

  MotherboardSelectionFilter(
      {this.selectedMaxPrice,
      this.selectedMinPrice,
      this.ramSlotsMin,
      this.ramSlotsMax,
      this.size,
      this.sockets,
      this.sort,
      this.order,
      this.allSizes,
      this.allSockets});

  MotherboardSelectionFilter get copy => MotherboardSelectionFilter(
      selectedMinPrice: this.selectedMinPrice,
      selectedMaxPrice: this.selectedMaxPrice,
      ramSlotsMin: this.ramSlotsMin,
      ramSlotsMax: this.ramSlotsMax,
      sockets: this.sockets.toList(),
      size: this.size.toList(),
      sort: this.sort,
      order: this.order,
      allSizes: this.allSizes,
      allSockets: this.allSockets);

  static bool areEquel(MotherboardSelectionFilter filter1, MotherboardSelectionFilter filter2) {
    return filter1.allSizes == filter2.allSizes &&
        filter1.allSockets == filter2.allSockets &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        filter1.ramSlotsMax == filter2.ramSlotsMax &&
        filter1.ramSlotsMin == filter2.ramSlotsMin &&
        filter1.selectedMaxPrice == filter2.selectedMaxPrice &&
        filter1.selectedMinPrice == filter2.selectedMinPrice &&
        listsEquel(filter1.size, filter2.size) &&
        listsEquel(filter1.sockets, filter2.sockets);
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

enum MotherboardSort { none, price }