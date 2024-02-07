class CartCountModel {
  int? cartCount;

  CartCountModel({this.cartCount});

  CartCountModel.fromJson(Map<String, dynamic> json) {
    cartCount = json['cartCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartCount'] = cartCount;
    return data;
  }
}
