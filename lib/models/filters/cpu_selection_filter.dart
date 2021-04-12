import 'package:equatable/equatable.dart';
import 'package:pc_builder/models/sort_order.dart';

class CPUSelectionFilter extends Equatable {
  bool showAmd;
  bool showIntel;

  int selectedMinCores;
  int selectedMaxCores;

  double selectedMinClock;
  double selectedMaxClock;

  double selectedMinPrice;
  double selectedMaxPrice;

  int selectedMinConsumption;
  int selectedMaxConsumption;

  CPUSort sort;
  SortOrder order;

  CPUSelectionFilter(
      {this.showAmd,
      this.showIntel,
      this.selectedMinCores,
      this.selectedMaxCores,
      this.selectedMinClock,
      this.selectedMaxClock,
      this.selectedMinPrice,
      this.selectedMaxConsumption,
      this.selectedMaxPrice,
      this.selectedMinConsumption,
      this.sort,
      this.order});

  CPUSelectionFilter copy() {
    return CPUSelectionFilter(
        showAmd: showAmd,
        showIntel: showIntel,
        selectedMinCores: selectedMinCores,
        selectedMaxCores: selectedMaxCores,
        selectedMinClock: selectedMinClock,
        selectedMaxClock: selectedMaxClock,
        selectedMaxPrice: selectedMaxPrice,
        selectedMinPrice: selectedMinPrice,
        selectedMaxConsumption: selectedMaxConsumption,
        selectedMinConsumption: selectedMinConsumption,
        sort: sort,
        order: order);
  }

  @override
  List<Object> get props => [
        showAmd,
        showIntel,
        selectedMinCores,
        selectedMaxCores,
        selectedMinClock,
        selectedMaxClock,
        selectedMinPrice,
        selectedMaxPrice,
        selectedMinConsumption,
        selectedMaxConsumption,
        sort,
        order
      ];
}

enum CPUSort { none, cores, clock, price, consumption }
