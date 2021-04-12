import 'package:pc_builder/models/sort_order.dart';

class PSUFilter{
  int selectedMinPower;
  int selectedMaxPower;

  double selectedMinPrice;
  double selectedMaxPrice;

  PSUSort sort;
  SortOrder order;

  List<String> formFactors;
  bool allFormFactors;

  List<String> efficiency;
  bool allEfficiency;

  PSUFilter(
      {this.selectedMaxPrice,
      this.selectedMinPrice,
      this.selectedMinPower,
      this.selectedMaxPower,
      this.sort,
      this.order,
      this.formFactors,
      this.allFormFactors,
      this.efficiency,
      this.allEfficiency});

  PSUFilter get copy => PSUFilter(
      selectedMinPrice: this.selectedMinPrice,
      selectedMaxPrice: this.selectedMaxPrice,
      selectedMinPower: this.selectedMinPower,
      selectedMaxPower: this.selectedMaxPower,
      sort: this.sort,
      order: this.order,
      efficiency: this.efficiency.toList(),
      allEfficiency: this.allEfficiency,
      formFactors: this.formFactors.toList(),
      allFormFactors: this.allFormFactors);

  static bool areEquel(PSUFilter filter1, PSUFilter filter2) {
    return filter1.selectedMinPrice == filter2.selectedMinPrice &&
        filter1.selectedMaxPrice == filter2.selectedMaxPrice &&
        filter1.selectedMinPower == filter2.selectedMinPower &&
        filter1.selectedMaxPower == filter2.selectedMaxPower &&
        filter1.order == filter2.order &&
        filter1.sort == filter2.sort &&
        filter1.allFormFactors == filter2.allFormFactors &&
        filter1.allEfficiency == filter2.allEfficiency &&
        listsEquel(filter1.efficiency, filter2.efficiency) &&
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

enum PSUSort { none, price, wattage }