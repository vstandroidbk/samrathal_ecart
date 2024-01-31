class OrderListModel {
  List<GetOrderData>? getOrderData;
  String? productImagePath;

  OrderListModel({this.getOrderData, this.productImagePath});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['getOrderData'] != null) {
      getOrderData = <GetOrderData>[];
      json['getOrderData'].forEach((v) {
        getOrderData!.add(GetOrderData.fromJson(v));
      });
    }
    productImagePath = json['productImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getOrderData != null) {
      data['getOrderData'] = getOrderData!.map((v) => v.toJson()).toList();
    }
    data['productImagePath'] = productImagePath;
    return data;
  }
}

class GetOrderData {
  String? id;
  String? orderId;
  int? orderStatus;
  int? totalItem;
  String? productImage;
  String? finalOrderAmount;
  String? orderDate;

  GetOrderData(
      {this.id,
      this.orderId,
      this.orderStatus,
      this.totalItem,
      this.productImage,
      this.finalOrderAmount,
      this.orderDate});

  GetOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
    totalItem = json['total_item'];
    productImage = json['product_image'];
    finalOrderAmount = json['final_order_amount'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['order_status'] = orderStatus;
    data['total_item'] = totalItem;
    data['product_image'] = productImage;
    data['final_order_amount'] = finalOrderAmount;
    data['order_date'] = orderDate;
    return data;
  }
}
