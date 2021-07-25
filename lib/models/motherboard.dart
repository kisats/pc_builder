import 'package:pc_builder/models/autobuild.dart';

class Motherboard {
  String image;
  int maxRam;
  String name;
  double price;
  int ramSlots;
  int rating;
  String size;
  String socket;

  double perfermanceScore;

  Motherboard(
      {this.image,
      this.maxRam,
      this.name,
      this.price,
      this.ramSlots,
      this.rating,
      this.size,
      this.socket});

  Motherboard.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    maxRam = json['maxRam'];
    name = json['name'];
    price = json['price'];
    ramSlots = json['ramSlots'];
    rating = json['rating'];
    size = json['size'];
    socket = json['socket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['maxRam'] = this.maxRam;
    data['name'] = this.name;
    data['price'] = this.price;
    data['ramSlots'] = this.ramSlots;
    data['rating'] = this.rating;
    data['size'] = this.size;
    data['socket'] = this.socket;
    return data;
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, price),
      Cell(2, maxRam?.toDouble() ?? 0),
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    return [
      CountingColumn(1, "Price",
          weights.price + weights.consumption + weights.storage + weights.gaming, false),
      CountingColumn(2, "Ram", weights.multitasking + weights.contentCreation, true),
    ];
  }
}
