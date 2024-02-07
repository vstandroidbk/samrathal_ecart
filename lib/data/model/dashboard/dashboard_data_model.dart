class DashboardDataModel {
  List<SliderData>? sliderData;
  List<OfferData>? offerData;
  List<ProductData>? productData;
  num? totalOrderCount;
  String? productImagePath;
  String? offerImagePath;
  String? sliderImagePath;

  DashboardDataModel(
      {this.sliderData,
      this.offerData,
      this.productData,
      this.totalOrderCount,
      this.productImagePath,
      this.offerImagePath,
      this.sliderImagePath});

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(SliderData.fromJson(v));
      });
    }
    if (json['offerData'] != null) {
      offerData = <OfferData>[];
      json['offerData'].forEach((v) {
        offerData!.add(OfferData.fromJson(v));
      });
    }
    if (json['productData'] != null) {
      productData = <ProductData>[];
      json['productData'].forEach((v) {
        productData!.add(ProductData.fromJson(v));
      });
    }
    totalOrderCount = json['totalOrderCount'];
    productImagePath = json['productImagePath'];
    offerImagePath = json['offerImagePath'];
    sliderImagePath = json['sliderImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliderData != null) {
      data['sliderData'] = sliderData!.map((v) => v.toJson()).toList();
    }
    if (offerData != null) {
      data['offerData'] = offerData!.map((v) => v.toJson()).toList();
    }
    if (productData != null) {
      data['productData'] = productData!.map((v) => v.toJson()).toList();
    }
    data['totalOrderCount'] = totalOrderCount;
    data['productImagePath'] = productImagePath;
    data['offerImagePath'] = offerImagePath;
    data['sliderImagePath'] = sliderImagePath;
    return data;
  }
}

class SliderData {
  String? sliderImage;

  SliderData({this.sliderImage});

  SliderData.fromJson(Map<String, dynamic> json) {
    sliderImage = json['slider_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slider_image'] = sliderImage;
    return data;
  }
}

class OfferData {
  String? id;
  String? offerImage;

  OfferData({this.id, this.offerImage});

  OfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerImage = json['offer_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offer_image'] = offerImage;
    return data;
  }
}

class ProductData {
  String? id;
  String? productName;
  String? sku;
  String? image;
  num? wishlistStatus;

  ProductData(
      {this.id, this.productName, this.sku, this.image, this.wishlistStatus});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    sku = json['sku'];
    image = json['image'];
    wishlistStatus = json['wishlist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['sku'] = sku;
    data['image'] = image;
    data['wishlist_status'] = wishlistStatus;
    return data;
  }
}
