import 'package:pc_builder/models/sort_order.dart';

class GraphicsCardFilter {
  int selectedMinMemory;
  int selectedMaxMemory;

  int selectedMinClock;
  int selectedMaxClock;

  double selectedMinPrice;
  double selectedMaxPrice;

  int selectedMinConsumption;
  int selectedMaxConsumption;

  GraphicsCardSort sort;
  SortOrder order;

  List<String> memoryTypes;
  bool allMemoryTypes;

  GraphicsCardFilter(
      {this.selectedMaxPrice,
      this.selectedMinPrice,
      this.selectedMinMemory,
      this.selectedMaxMemory,
      this.selectedMinClock,
      this.selectedMaxClock,
      this.sort,
      this.order,
      this.selectedMinConsumption,
      this.selectedMaxConsumption,
      this.memoryTypes,
      this.allMemoryTypes});

  GraphicsCardFilter get copy => GraphicsCardFilter(
      selectedMinPrice: this.selectedMinPrice,
      selectedMaxPrice: this.selectedMaxPrice,
      selectedMinMemory: this.selectedMinMemory,
      selectedMaxMemory: this.selectedMaxMemory,
      selectedMinClock: this.selectedMinClock,
      selectedMaxClock: this.selectedMaxClock,
      selectedMinConsumption: this.selectedMinConsumption,
      selectedMaxConsumption: this.selectedMaxConsumption,
      sort: this.sort,
      order: this.order,
      memoryTypes: this.memoryTypes.toList(),
      allMemoryTypes: this.allMemoryTypes);

  static bool areEquel(GraphicsCardFilter filter1, GraphicsCardFilter filter2) {
    return filter1.selectedMinPrice == filter2.selectedMinPrice &&
        filter1.selectedMaxPrice == filter2.selectedMaxPrice &&
        filter1.selectedMinMemory == filter2.selectedMinMemory &&
        filter1.selectedMaxMemory == filter2.selectedMaxMemory &&
        filter1.selectedMinConsumption == filter2.selectedMinConsumption &&
        filter1.selectedMaxConsumption == filter2.selectedMaxConsumption &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        filter1.allMemoryTypes == filter2.allMemoryTypes &&
        filter1.selectedMaxClock == filter2.selectedMaxClock &&
        filter1.selectedMinClock == filter2.selectedMinClock &&
        listsEquel(filter1.memoryTypes, filter2.memoryTypes);
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

enum GraphicsCardSort { none, price, clock, memory, consumption }
