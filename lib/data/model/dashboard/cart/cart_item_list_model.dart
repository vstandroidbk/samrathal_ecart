class CartItemListModel {
  List<CartData>? cartData;
  CartAddressData? addressData;
  String? productImagePath;
  num? shippingAmount;
  num? distance;

  CartItemListModel(
      {this.cartData,
      this.addressData,
      this.productImagePath,
      this.shippingAmount,
      this.distance});

  CartItemListModel.fromJson(Map<String, dynamic> json) {
    if (json['cartData'] != null) {
      cartData = <CartData>[];
      json['cartData'].forEach((v) {
        cartData!.add(CartData.fromJson(v));
      });
    }
    addressData = json['addressData'] != null
        ? CartAddressData.fromJson(json['addressData'])
        : null;
    productImagePath = json['productImagePath'];
    shippingAmount = json['shipping_amount'];
    distance = json['shipping_distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartData != null) {
      data['cartData'] = cartData!.map((v) => v.toJson()).toList();
    }
    if (addressData != null) {
      data['addressData'] = addressData!.toJson();
    }
    data['productImagePath'] = productImagePath;
    data['shipping_amount'] = shippingAmount;
    data['shipping_distance'] = distance;
    return data;
  }
}

class CartData {
  String? productId;
  String? itemData;
  ProductData? productData;

  CartData({this.productId, this.itemData, this.productData});

  CartData.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    itemData = json['item_data'];
    productData = json['productData'] != null
        ? ProductData.fromJson(json['productData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['item_data'] = itemData;
    if (productData != null) {
      data['productData'] = productData!.toJson();
    }
    return data;
  }
}

class ProductData {
  String? productName;
  String? image;
  String? retailTonAmount;
  String? wholeSaleTonAmount;
  int? wholeSaleTonMinQty;

  ProductData(
      {this.productName,
      this.image,
      this.retailTonAmount,
      this.wholeSaleTonAmount,
      this.wholeSaleTonMinQty});

  ProductData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    image = json['image'];
    retailTonAmount = json['retail_ton_amount'];
    wholeSaleTonAmount = json['whole_sale_ton_amount'];
    wholeSaleTonMinQty = json['whole_sale_ton_min_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['image'] = image;
    data['retail_ton_amount'] = retailTonAmount;
    data['whole_sale_ton_amount'] = wholeSaleTonAmount;
    data['whole_sale_ton_min_qty'] = wholeSaleTonMinQty;
    return data;
  }
}

class CartAddressData {
  String? id;
  String? address;
  int? zipCode;
  String? landmark;
  int? primaryStatus;
  CartStateData? stateData;
  CartDistrictData? districtData;

  CartAddressData(
      {this.id,
      this.address,
      this.zipCode,
      this.landmark,
      this.primaryStatus,
      this.stateData,
      this.districtData});

  CartAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    primaryStatus = json['primary_status'];
    stateData = json['stateData'] != null
        ? CartStateData.fromJson(json['stateData'])
        : null;
    districtData = json['districtData'] != null
        ? CartDistrictData.fromJson(json['districtData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['zip_code'] = zipCode;
    data['landmark'] = landmark;
    data['primary_status'] = primaryStatus;
    if (stateData != null) {
      data['stateData'] = stateData!.toJson();
    }
    if (districtData != null) {
      data['districtData'] = districtData!.toJson();
    }
    return data;
  }
}

class CartStateData {
  String? stateName;

  CartStateData({this.stateName});

  CartStateData.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_name'] = stateName;
    return data;
  }
}

class CartDistrictData {
  String? districtName;

  CartDistrictData({this.districtName});

  CartDistrictData.fromJson(Map<String, dynamic> json) {
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district_name'] = districtName;
    return data;
  }
}
