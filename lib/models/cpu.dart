class Cpu {
  String image;
  int cores;
  double price;
  String name;
  double speed;
  double boost;
  int rating;
  int consumption;

  Cpu(
      {this.image,
      this.cores,
      this.price,
      this.name,
      this.speed,
      this.boost,
      this.rating,
      this.consumption});

  Cpu.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    cores = json['cores'];
    price = json['price'];
    name = json['name'];
    speed = json['speed'];
    boost = json['boost'];
    rating = json['rating'];
    consumption = json['consumption'];
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
    return data;
  }
}
