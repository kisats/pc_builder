class Case {
  int externalBays;
  String image;
  int internalBays;
  String name;
  double price;
  int rating;
  String sidePanel;
  String type;

  Case(
      {this.externalBays,
      this.image,
      this.internalBays,
      this.name,
      this.price,
      this.rating,
      this.sidePanel,
      this.type});

  Case.fromJson(Map<String, dynamic> json) {
    externalBays = json['externalBays'];
    image = json['image'];
    internalBays = json['internalBays'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    sidePanel = json['sidePanel'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['externalBays'] = this.externalBays;
    data['image'] = this.image;
    data['internalBays'] = this.internalBays;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['sidePanel'] = this.sidePanel;
    data['type'] = this.type;
    return data;
  }
}