import 'package:pc_builder/models/autobuild.dart';

class RAM {
  String name;
  double casLatency;
  double fwLatency;
  String image;
  double price;
  double priceGB;
  int speed;
  String memoryType;
  int stickCount;
  int stickMemory;
  double voltage;

  double perfermanceScore;

  RAM(
      {this.name,
      this.casLatency,
      this.fwLatency,
      this.image,
      this.price,
      this.priceGB,
      this.speed,
      this.stickCount,
      this.stickMemory,
      this.voltage});

  RAM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    casLatency = json['casLatency'] ?? 0;
    fwLatency = json['fwLatency'] ?? 0;
    image = json['image'];
    price = json['price'] ?? 0;
    priceGB = json['priceGB'] ?? 0;
    speed = json['speed'] ?? 0;
    memoryType = json['memoryType'];
    stickCount = json['stickCount'] ?? 0;
    stickMemory = json['stickMemory'] ?? 0;
    voltage = json['voltage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['casLatency'] = this.casLatency;
    data['fwLatency'] = this.fwLatency;
    data['image'] = this.image;
    data['price'] = this.price;
    data['priceGB'] = this.priceGB;
    data['speed'] = this.speed;
    data['stickCount'] = this.stickCount;
    data['stickMemory'] = this.stickMemory;
    data['voltage'] = this.voltage;
    data['speed'] = this.speed;
    data['memoryType'] = this.memoryType;
    return data;
  }

  double get ddrValue {
    switch (memoryType) {
      case "DDR2":
        return 2;
      case "DDR3":
        return 4;
      case "DDR4":
        return 7;
      default:
        return 0;
    }
  }

  CountingRow toCountingRow() {
    return CountingRow(this, [
      Cell(1, voltage),
      Cell(2, (stickMemory * stickCount).toDouble()),
      Cell(3, price),
      Cell(4, casLatency),
      Cell(5, fwLatency),
      Cell(6, ddrValue),
      Cell(7, speed.toDouble())
    ]);
  }

  static List<CountingColumn> getCountingColumns(BuildWeights weights) {
    var ramValue = weights.multitasking * 2 +
        weights.contentCreation / 1.33 +
        weights.gaming / 1.66 +
        weights.storage / 2 +
        weights.consumption / 2;

    return [
      CountingColumn(1, "Voltage", ramValue * 0.1, true),
      CountingColumn(2, "Memory", ramValue * 0.20, true),
      CountingColumn(
          3, "Price", weights.price + weights.storage / 2 + weights.consumption / 2, false),
      CountingColumn(4, "CasLatency", ramValue * 0.1, true),
      CountingColumn(5, "FwLatency", ramValue * 0.1, true),
      CountingColumn(6, "DDR", ramValue * 0.28, true),
      CountingColumn(7, "Speed", ramValue * 0.22, true),
    ];
  }
}
