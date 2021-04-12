import 'package:pc_builder/models/sort_order.dart';

class StorageFilter{
  int selectedMinMemory;
  int selectedMaxMemory;

  double selectedMinPrice;
  double selectedMaxPrice;

  StorageSort sort;
  SortOrder order;

  bool nvme;
  bool sata;

  List<String> formFactors;
  bool allFormFactors;

  StorageFilter(
      {this.selectedMaxPrice,
      this.selectedMinPrice,
      this.selectedMinMemory,
      this.selectedMaxMemory,
      this.sort,
      this.order,
      this.formFactors,
      this.allFormFactors,
      this.nvme,
      this.sata});

  StorageFilter get copy => StorageFilter(
      selectedMinPrice: this.selectedMinPrice,
      selectedMaxPrice: this.selectedMaxPrice,
      selectedMinMemory: this.selectedMinMemory,
      selectedMaxMemory: this.selectedMaxMemory,
      sort: this.sort,
      order: this.order,
      nvme: this.nvme,
      sata: this.sata,
      formFactors: this.formFactors.toList(),
      allFormFactors: this.allFormFactors);

  static bool areEquel(StorageFilter filter1, StorageFilter filter2) {
    return filter1.selectedMinPrice == filter2.selectedMinPrice &&
        filter1.selectedMaxPrice == filter2.selectedMaxPrice &&
        filter1.selectedMinMemory == filter2.selectedMinMemory &&
        filter1.selectedMaxMemory == filter2.selectedMaxMemory &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        filter1.allFormFactors == filter2.allFormFactors &&
        filter1.nvme == filter2.nvme &&
        filter1.sata == filter2.sata &&
        listsEquel(filter1.formFactors, filter2.formFactors);
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

enum StorageSort { none, price, memory }