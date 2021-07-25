import 'package:pc_builder/models/autobuild.dart';

class Cpu {
  String image;
  int cores;
  double price;
  String name;
  double speed;
  double boost;
  int rating;
  int consumption;
  String socket;
  String architecture;
  String coreFamily;

  double perfermanceScore;

  bool get isIntel => name.contains("Intel");
  bool get isAMD => name.contains("AMD");

  Cpu(
      {this.image,
      this.cores,
      this.price,
      this.name,
      this.speed,
      this.boost,
      this.rating,
      this.consumption,
      this.socket,
      this.architecture,
      this.coreFamily});

  Cpu.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    cores = json['cores'] ?? 0;
    price = json['price'] ?? 0;
    name = json['name'];
    speed = json['speed'] ?? 0;
    boost = json['boost'] ?? speed;
    rating = json['rating'];
    consumption = json['consumption'] ?? 180;
    socket = json['socket'];
    architecture = json['architecture'];
    coreFamily = json['coreFamily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['cores'] = this.cores;
    data['price'] = this.price;
    data['name'] = this.name;
    data['speed'] = this.speed;
    data['boost'] = this.boost;
    data['rating'] = this.rating;
    data['consumption'] = this.consumption;
    data['socket'] = this.socket;
    data['architecture'] = this.architecture;
    data['coreFamily'] = this.coreFamily;
    return data;
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, cores.toDouble()),
      Cell(2, speed),
      Cell(3, boost ?? speed),
      Cell(4, price),
      Cell(5, consumption?.toDouble() ?? 180)
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    return [
      CountingColumn(1, "Cores", weights.multitasking + weights.storage / 5, true),
      CountingColumn(2, "Speed",
          weights.contentCreation / 1.5 + weights.gaming / 3 + weights.storage / 5, true),
      CountingColumn(3, "Boost",
          weights.contentCreation / 1.5 + weights.gaming / 3 + weights.storage / 5, true),
      CountingColumn(4, "Price", weights.price + weights.storage / 5, false),
      CountingColumn(5, "Consumption", weights.consumption + weights.storage / 5, false)
    ];
  }
}
