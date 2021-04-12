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

    double get ddrValue{
    switch (memoryType) {
      case "DDR2": return 2;
      case "DDR3": return 4;
      case "DDR4": return 7;
      default: return 0;
    }
  }
}
