class WishListModel {
  List<WishListData>? wishListData;
  String? productImagePath;

  WishListModel({this.wishListData, this.productImagePath});

  WishListModel.fromJson(Map<String, dynamic> json) {
    if (json['wishListData'] != null) {
      wishListData = <WishListData>[];
      json['wishListData'].forEach((v) {
        wishListData!.add(WishListData.fromJson(v));
      });
    }
    productImagePath = json['productImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishListData != null) {
      data['wishListData'] = wishListData!.map((v) => v.toJson()).toList();
    }
    data['productImagePath'] = productImagePath;
    return data;
  }
}

class WishListData {
  String? productId;
  String? image;
  String? productName;
  String? sku;

  WishListData({this.productId, this.image, this.productName, this.sku});

  WishListData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    image = json['image'];
    productName = json['product_name'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['image'] = image;
    data['product_name'] = productName;
    data['sku'] = sku;
    return data;
  }
}
