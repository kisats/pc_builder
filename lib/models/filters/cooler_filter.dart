import 'package:equatable/equatable.dart';
import 'package:pc_builder/models/sort_order.dart';

class CoolerFilter extends Equatable {
  int noiseMin;
  int noiseMax;

  double selectedPriceMin;
  double selectedPriceMax;

  CoolerSort sort;
  SortOrder order;

  bool showWaterCooled;
  bool showAirCooled;

  CoolerFilter(
      {this.noiseMin,
      this.noiseMax,
      this.selectedPriceMin,
      this.selectedPriceMax,
      this.sort,
      this.order,
      this.showAirCooled,
      this.showWaterCooled});

  CoolerFilter get copy => CoolerFilter(
      noiseMin: this.noiseMin,
      noiseMax: this.noiseMax,
      selectedPriceMin: this.selectedPriceMin,
      selectedPriceMax: this.selectedPriceMax,
      sort: this.sort,
      order: this.order,
      showWaterCooled: this.showWaterCooled,
      showAirCooled: this.showAirCooled);

  @override
  List<Object> get props => [
        noiseMin,
        noiseMax,
        selectedPriceMin,
        selectedPriceMax,
        sort,
        order,
        showAirCooled,
        showWaterCooled
      ];
}

enum CoolerSort { none, price, rpm, noise }
