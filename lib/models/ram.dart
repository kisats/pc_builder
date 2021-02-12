class RAM {
  String name;
  double casLatency;
  double fwLatency;
  String image;
  double price;
  double priceGB;
  String speed;
  int stickCount;
  int stickMemory;

  RAM(
      {this.name,
      this.casLatency,
      this.fwLatency,
      this.image,
      this.price,
      this.priceGB,
      this.speed,
      this.stickCount,
      this.stickMemory});

  RAM.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    casLatency = json['casLatency'];
    fwLatency = json['fwLatency'];
    image = json['image'];
    price = json['price'];
    priceGB = json['priceGB'];
    speed = json['speed'];
    stickCount = json['stickCount'];
    stickMemory = json['stickMemory'];
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
    return data;
  }
}
