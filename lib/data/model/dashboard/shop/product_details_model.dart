class ProductDetailsModel {
  ProductDetails? productDetails;
  String? productImagePath;

  ProductDetailsModel({this.productDetails, this.productImagePath});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    productDetails = json['productDetails'] != null
        ? ProductDetails.fromJson(json['productDetails'])
        : null;
    productImagePath = json['productImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productDetails != null) {
      data['productDetails'] = productDetails!.toJson();
    }
    data['productImagePath'] = productImagePath;
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? productUrl;
  String? sku;
  String? image;
  String? shortDescription;
  String? longDescription;
  String? retailTonAmount;
  String? wholeSaleTonAmount;
  int? wholeSaleTonMinQty;

  ProductDetails(
      {this.id,
      this.productName,
      this.productUrl,
      this.sku,
      this.image,
      this.shortDescription,
      this.longDescription,
      this.retailTonAmount,
      this.wholeSaleTonAmount,
      this.wholeSaleTonMinQty});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productUrl = json['product_url'];
    sku = json['sku'];
    image = json['image'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    retailTonAmount = json['retail_ton_amount'];
    wholeSaleTonAmount = json['whole_sale_ton_amount'];
    wholeSaleTonMinQty = json['whole_sale_ton_min_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['product_url'] = productUrl;
    data['sku'] = sku;
    data['image'] = image;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['retail_ton_amount'] = retailTonAmount;
    data['whole_sale_ton_amount'] = wholeSaleTonAmount;
    data['whole_sale_ton_min_qty'] = wholeSaleTonMinQty;
    return data;
  }
}
