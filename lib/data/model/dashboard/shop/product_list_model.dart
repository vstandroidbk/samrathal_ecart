class ProductListModel {
  List<ProductListData>? productListData;
  String? productImagePath;

  ProductListModel({this.productListData, this.productImagePath});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['productListData'] != null) {
      productListData = <ProductListData>[];
      json['productListData'].forEach((v) {
        productListData!.add(ProductListData.fromJson(v));
      });
    }
    productImagePath = json['productImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productListData != null) {
      data['productListData'] =
          productListData!.map((v) => v.toJson()).toList();
    }
    data['productImagePath'] = productImagePath;
    return data;
  }
}

class ProductListData {
  String? id;
  String? productName;
  String? sku;
  String? image;

  ProductListData({this.id, this.productName, this.sku, this.image});

  ProductListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    sku = json['sku'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['sku'] = sku;
    data['image'] = image;
    return data;
  }
}
