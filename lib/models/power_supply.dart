class PowerSupply {
  String efficiency;
  String formFactor;
  String image;
  String modular;
  String name;
  double price;
  int rating;
  int wattage;

  PowerSupply(
      {this.efficiency,
      this.formFactor,
      this.image,
      this.modular,
      this.name,
      this.price,
      this.rating,
      this.wattage});

  PowerSupply.fromJson(Map<String, dynamic> json) {
    efficiency = json['efficiency'];
    formFactor = json['formFactor'];
    image = json['image'];
    modular = json['modular'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    wattage = json['wattage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['efficiency'] = this.efficiency;
    data['formFactor'] = this.formFactor;
    data['image'] = this.image;
    data['modular'] = this.modular;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['wattage'] = this.wattage;
    return data;
  }
}