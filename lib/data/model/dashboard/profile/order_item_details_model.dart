class OrderItemDetailsModel {
  GetOrderItemData? getOrderData;
  List<OrderItemData>? orderItemData;
  String? productImagePath;

  OrderItemDetailsModel(
      {this.getOrderData, this.orderItemData, this.productImagePath});

  OrderItemDetailsModel.fromJson(Map<String, dynamic> json) {
    getOrderData = json['getOrderData'] != null
        ? GetOrderItemData.fromJson(json['getOrderData'])
        : null;
    if (json['orderItemData'] != null) {
      orderItemData = <OrderItemData>[];
      json['orderItemData'].forEach((v) {
        orderItemData!.add(OrderItemData.fromJson(v));
      });
    }
    productImagePath = json['productImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getOrderData != null) {
      data['getOrderData'] = getOrderData!.toJson();
    }
    if (orderItemData != null) {
      data['orderItemData'] = orderItemData!.map((v) => v.toJson()).toList();
    }
    data['productImagePath'] = productImagePath;
    return data;
  }
}

class GetOrderItemData {
  String? orderAmount;
  String? shippingAmount;
  String? finalOrderAmount;
  String? settlementPrice;
  String? settlementPriceType;

  GetOrderItemData(
      {this.orderAmount,
      this.shippingAmount,
      this.finalOrderAmount,
      this.settlementPrice,
      this.settlementPriceType});

  GetOrderItemData.fromJson(Map<String, dynamic> json) {
    orderAmount = json['order_amount'];
    shippingAmount = json['shipping_amount'];
    finalOrderAmount = json['final_order_amount'];
    settlementPrice = json['settlement_price'];
    settlementPriceType = json['settlement_price_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_amount'] = orderAmount;
    data['shipping_amount'] = shippingAmount;
    data['final_order_amount'] = finalOrderAmount;
    data['settlement_price'] = settlementPrice;
    data['settlement_price_type'] = settlementPriceType;
    return data;
  }
}

class OrderItemData {
  String? productName;
  String? image;
  String? retailTonAmount;
  String? wholeSaleTonAmount;
  String? wholeSaleTonMinQty;
  String? itemData;

  OrderItemData(
      {this.productName,
      this.image,
      this.retailTonAmount,
      this.wholeSaleTonAmount,
      this.wholeSaleTonMinQty,
      this.itemData});

  OrderItemData.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    image = json['image'];
    retailTonAmount = json['retail_ton_amount'];
    wholeSaleTonAmount = json['whole_sale_ton_amount'];
    wholeSaleTonMinQty = json['whole_sale_ton_min_qty'];
    itemData = json['item_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['image'] = image;
    data['retail_ton_amount'] = retailTonAmount;
    data['whole_sale_ton_amount'] = wholeSaleTonAmount;
    data['whole_sale_ton_min_qty'] = wholeSaleTonMinQty;
    data['item_data'] = itemData;
    return data;
  }
}
