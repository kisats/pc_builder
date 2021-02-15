import 'package:equatable/equatable.dart';

class MotherboardSelectionFilter extends Equatable {
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
      sockets: this.sockets,
      size: this.size,
      sort: this.sort,
      order: this.order,
      allSizes: this.allSizes,
      allSockets: this.allSockets);

  @override
  List<Object> get props => [
        selectedMinPrice,
        selectedMaxPrice,
        ramSlotsMin,
        ramSlotsMax,
        sockets,
        size,
        allSizes,
        allSockets
      ];
}

enum MotherboardSort { none, price }

enum SortOrder { ascending, descending, none }
