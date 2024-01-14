class CartModel {
  String? name;
  String? id;
  double? price;
  String? picture;
  int? quantity;
  CartModel({required this.name,required  this.id, required this.price,required this.picture , required this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    picture = json['picture'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['price'] = this.price;
    data['picture'] = this.picture;
    data['quantity'] = this.quantity;
    return data;
  }
}