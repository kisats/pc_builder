import 'package:pc_builder/models/autobuild.dart';

class Cooler {
  String image;
  double maxNoise;
  int maxRPM;
  double minNoise;
  int minRPM;
  String name;
  double price;
  int radiatorSize;
  int rating;

  double perfermanceScore;

  Cooler(
      {this.image,
      this.maxNoise,
      this.maxRPM,
      this.minNoise,
      this.minRPM,
      this.name,
      this.price,
      this.radiatorSize,
      this.rating});

  Cooler.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    maxNoise = json['maxNoise'];
    maxRPM = json['maxRPM'];
    minNoise = json['minNoise'];
    minRPM = json['minRPM'];
    name = json['name'];
    price = json['price'];
    radiatorSize = json['radiatorSize'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['maxNoise'] = this.maxNoise;
    data['maxRPM'] = this.maxRPM;
    data['minNoise'] = this.minNoise;
    data['minRPM'] = this.minRPM;
    data['name'] = this.name;
    data['price'] = this.price;
    data['radiatorSize'] = this.radiatorSize;
    data['rating'] = this.rating;
    return data;
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, minRPM?.toDouble() ?? 0),
      Cell(2, maxRPM?.toDouble() ?? 0),
      Cell(3, minNoise?.toDouble() ?? 0),
      Cell(4, maxNoise?.toDouble() ?? 0),
      Cell(5, price),
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    var cooler = weights.consumption + weights.gaming + weights.storage;
    var collerMultitaskImpact = weights.contentCreation + weights.multitasking;

    return [
      CountingColumn(1, "MinRPM", collerMultitaskImpact * 0.30 + cooler * 0.05, false),
      CountingColumn(2, "MaxRPM", collerMultitaskImpact * 0.40 + cooler * 0.05, true),
      CountingColumn(3, "MinNoise", collerMultitaskImpact * 0.25 + cooler * 0.05, false),
      CountingColumn(4, "MaxNoise", collerMultitaskImpact * 0.05 + cooler * 0.05, false),
      CountingColumn(5, "Price", weights.price + cooler * 0.8, false),
    ];
  }
}
