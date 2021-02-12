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
}
