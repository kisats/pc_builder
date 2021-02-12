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

  VideoCard(
      {this.boost,
      this.chipset,
      this.clock,
      this.image,
      this.length,
      this.memory,
      this.name,
      this.price,
      this.rating});

  VideoCard.fromJson(Map<String, dynamic> json) {
    boost = json['boost'];
    chipset = json['chipset'];
    clock = json['clock'];
    image = json['image'];
    length = json['length'];
    memory = json['memory'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
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
    return data;
  }
}