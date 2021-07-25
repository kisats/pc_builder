import 'package:pc_builder/models/autobuild.dart';

class SSD {
  int cache;
  double capacity;
  String formFactor;
  String image;
  String interface;
  bool isNVME;
  String name;
  double price;
  double priceGB;
  int rating;

  double perfermanceScore;

  SSD(
      {this.cache,
      this.capacity,
      this.formFactor,
      this.image,
      this.interface,
      this.isNVME,
      this.name,
      this.price,
      this.priceGB,
      this.rating});

  SSD.fromJson(Map<String, dynamic> json) {
    cache = json['cache'] ?? 0;
    capacity = json['capacity'] ?? 0;
    formFactor = json['formFactor'];
    image = json['image'];
    interface = json['interface'];
    isNVME = json['isNVME'];
    name = json['name'];
    price = json['price'] ?? 0;
    priceGB = json['priceGB'] ?? 0;
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cache'] = this.cache;
    data['capacity'] = this.capacity;
    data['formFactor'] = this.formFactor;
    data['image'] = this.image;
    data['interface'] = this.interface;
    data['isNVME'] = this.isNVME;
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceGB'] = this.priceGB;
    data['rating'] = this.rating;
    return data;
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, capacity),
      Cell(2, cache?.toDouble() ?? 0),
      Cell(3, price),
      Cell(4, isNVME ? 1.5 : 0.4),
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    var ssdValue = weights.storage * 2 +
        weights.multitasking / 1.33 +
        weights.contentCreation / 1.66 +
        weights.gaming / 4 +
        weights.consumption / 4;

    return [
      CountingColumn(1, "Storage", ssdValue * 0.5, true),
      CountingColumn(2, "Cache", ssdValue * 0.25, true),
      CountingColumn(
          3, "Price", weights.price + weights.consumption / 2, false),
      CountingColumn(4, "Nvme", ssdValue * 0.25, true),
    ];
  }
}
