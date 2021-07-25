import 'package:pc_builder/models/autobuild.dart';

class PowerSupply {
  String efficiency;
  String formFactor;
  String image;
  String modular;
  String name;
  double price;
  int rating;
  int wattage;

  double perfermanceScore;

  PowerSupply(
      {this.efficiency,
      this.formFactor,
      this.image,
      this.modular,
      this.name,
      this.price,
      this.rating,
      this.wattage});

  double get efficiencyValue {
    switch (efficiency) {
      case "80+":
        return 4;
      case "80+ Bronze":
        return 5;
      case "80+ Silver":
        return 6;
      case "80+ Gold":
        return 7;
      case "80+ Platinum":
        return 8;
      case "80+ Titanium":
        return 9;
      default:
        return 0;
    }
  }

  PowerSupply.fromJson(Map<String, dynamic> json) {
    efficiency = json['efficiency'];
    formFactor = json['formFactor'];
    image = json['image'];
    modular = json['modular'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    wattage = (json['wattage'] as double).floor();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['efficiency'] = this.efficiency;
    data['formFactor'] = this.formFactor;
    data['image'] = this.image;
    data['modular'] = this.modular;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['wattage'] = this.wattage;
    return data;
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, wattage.toDouble()),
      Cell(2, price),
      Cell(3, efficiencyValue),
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    var psu = weights.storage + weights.gaming + weights.multitasking + weights.contentCreation;

    return [
      CountingColumn(1, "Wattage", weights.consumption * 0.1 + psu * 0.05, true),
      CountingColumn(2, "Price", weights.price + psu * 0.75, false),
      CountingColumn(3, "Efficiency", weights.consumption * 0.9 + psu * 0.20, true),
    ];
  }
}
