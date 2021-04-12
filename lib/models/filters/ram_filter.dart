import 'package:pc_builder/models/sort_order.dart';

class RAMFilter{
  int selectedMinMemory;
  int selectedMaxMemory;

  int selectedMinSpeed;
  int selectedMaxSpeed;

  double selectedMinPrice;
  double selectedMaxPrice;

  double selectedMinVoltage;
  double selectedMaxVoltage;

  RAMSort sort;
  SortOrder order;

  List<String> memoryTypes;
  bool allMemoryTypes;

  RAMFilter(
      {this.selectedMaxPrice,
      this.selectedMinPrice,
      this.selectedMinMemory,
      this.selectedMaxMemory,
      this.selectedMinSpeed,
      this.selectedMaxSpeed,
      this.sort,
      this.order,
      this.selectedMinVoltage,
      this.selectedMaxVoltage,
      this.memoryTypes,
      this.allMemoryTypes});

  RAMFilter get copy => RAMFilter(
      selectedMinPrice: this.selectedMinPrice,
      selectedMaxPrice: this.selectedMaxPrice,
      selectedMinMemory: this.selectedMinMemory,
      selectedMaxMemory: this.selectedMaxMemory,
      selectedMinSpeed: this.selectedMinSpeed,
      selectedMaxSpeed: this.selectedMaxSpeed,
      selectedMinVoltage: this.selectedMinVoltage,
      selectedMaxVoltage: this.selectedMaxVoltage,
      sort: this.sort,
      order: this.order,
      memoryTypes: this.memoryTypes.toList(),
      allMemoryTypes: this.allMemoryTypes);

  static bool areEquel(RAMFilter filter1, RAMFilter filter2) {
    return filter1.selectedMinPrice == filter2.selectedMinPrice &&
        filter1.selectedMaxPrice == filter2.selectedMaxPrice &&
        filter1.selectedMinMemory == filter2.selectedMinMemory &&
        filter1.selectedMaxMemory == filter2.selectedMaxMemory &&
        filter1.selectedMinVoltage == filter2.selectedMinVoltage &&
        filter1.selectedMaxVoltage == filter2.selectedMaxVoltage &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        filter1.allMemoryTypes == filter2.allMemoryTypes &&
        filter1.selectedMinSpeed == filter2.selectedMinSpeed &&
        filter1.selectedMaxVoltage == filter2.selectedMaxVoltage &&
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

enum RAMSort { none, price, speed, memory, voltage }