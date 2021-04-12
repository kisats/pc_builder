class VideoCard {
  int boost;
  String chipset;
  int clock;
  String image;
  double length;
  int memory;
  String name;
  double price;
  int rating;
  int consumption;
  String cooling;
  String memoryType;

  double perfermanceScore;

  VideoCard(
      {this.boost,
      this.chipset,
      this.clock,
      this.image,
      this.length,
      this.memory,
      this.name,
      this.price,
      this.rating,
      this.consumption,
      this.cooling,
      this.memoryType});

  VideoCard.fromJson(Map<String, dynamic> json) {
    chipset = json['chipset'];
    clock = json['clock'] ?? 0;
    boost = json['boost'] ?? clock;
    image = json['image'];
    length = json['length']?.toDouble();
    memory = json['memory'] ?? 0;
    name = json['name'];
    price = json['price']?.toDouble();
    rating = json['rating'];
    consumption = json['consumption'] ?? 300;
    cooling = json['cooling'];
    memoryType = json['memoryType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boost'] = this.boost;
    data['chipset'] = this.chipset;
    data['clock'] = this.clock;
    data['image'] = this.image;
    data['length'] = this.length;
    data['memory'] = this.memory;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['consumption'] = this.consumption;
    data['cooling'] = this.cooling;
    data['memoryType'] = this.memoryType;
    return data;
  }

  double get ddrValue {
    switch (memoryType) {
      case "DDR3":
        return 2;
      case "DDR4":
        return 4;
      case "GDDR2":
        return 5;
      case "GDDR3":
        return 7;
      case "GDDR4":
        return 9;
      case "GDDR5":
        return 11;
      case "GDDR5X":
        return 12;
      case "GDDR6":
        return 13;
      case "GDDR6X":
        return 14;
      default:
        return 0;
    }
  }

  double get coolingValue {
    switch (cooling) {
      case "1 Fan": return 1;
      case "2 Fans": return 1.5;
      case "3 Fans": return 2;
      case "4 Fans": return 2.5;        
      default: return 0;
    }
  }
}
