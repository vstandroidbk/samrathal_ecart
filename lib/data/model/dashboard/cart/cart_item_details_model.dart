class CartItemDetailsModel {
  String? productId;
  List<ItemData>? itemData;

  CartItemDetailsModel({this.productId, this.itemData});

  CartItemDetailsModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    if (json['itemData'] != null) {
      itemData = <ItemData>[];
      json['itemData'].forEach((v) {
        itemData!.add(ItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    if (itemData != null) {
      data['itemData'] = itemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemData {
  String? size;
  String? quantity;
  String? weightType;

  ItemData({this.size, this.quantity, this.weightType});

  ItemData.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    quantity = json['quantity'];
    weightType = json['weight_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['quantity'] = quantity;
    data['weight_type'] = weightType;
    return data;
  }
}
