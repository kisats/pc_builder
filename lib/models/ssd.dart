class SSD {
  int cache;
  int capacity;
  String formFactor;
  String image;
  String interface;
  bool isNVME;
  String name;
  double price;
  double priceGB;
  int rating;

  SSD(
      {this.cache,
      this.capacity,
      this.formFactor,
      this.image,
      this.interface,
      this.isNVME,
      this.name,
      this.price,
      this.priceGB,
      this.rating});

  SSD.fromJson(Map<String, dynamic> json) {
    cache = json['cache'];
    capacity = json['capacity'];
    formFactor = json['formFactor'];
    image = json['image'];
    interface = json['interface'];
    isNVME = json['isNVME'];
    name = json['name'];
    price = json['price'];
    priceGB = json['priceGB'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cache'] = this.cache;
    data['capacity'] = this.capacity;
    data['formFactor'] = this.formFactor;
    data['image'] = this.image;
    data['interface'] = this.interface;
    data['isNVME'] = this.isNVME;
    data['name'] = this.name;
    data['price'] = this.price;
    data['priceGB'] = this.priceGB;
    data['rating'] = this.rating;
    return data;
  }
}
