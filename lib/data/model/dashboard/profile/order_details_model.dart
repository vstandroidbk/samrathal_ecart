class OrderDetailsModel {
  GetOrderDetailsData? getOrderDetailsData;

  OrderDetailsModel({this.getOrderDetailsData});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    getOrderDetailsData = json['getOrderDetailsData'] != null
        ? GetOrderDetailsData.fromJson(json['getOrderDetailsData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getOrderDetailsData != null) {
      data['getOrderDetailsData'] = getOrderDetailsData!.toJson();
    }
    return data;
  }
}

class GetOrderDetailsData {
  int? orderStatus;
  String? orderToken;
  String? orderDate;
  String? orderApproveDate;
  String? orderShippedDate;
  String? orderReceiveDate;
  String? orderCompleteDate;
  String? orderDeliverDate;
  int? totalItem;
  String? orderAmount;
  String? shippingAmount;
  String? finalOrderAmount;
  String? stateName;
  String? cityName;
  String? pincode;
  String? address;
  String? landmark;
  String? settlementPrice;
  String? settlementPriceType;
  bool? finalPaymentStatus;

  GetOrderDetailsData(
      {this.orderStatus,
      this.orderToken,
      this.orderDate,
      this.orderApproveDate,
      this.orderShippedDate,
      this.orderReceiveDate,
      this.orderCompleteDate,
      this.orderDeliverDate,
      this.totalItem,
      this.orderAmount,
      this.shippingAmount,
      this.finalOrderAmount,
      this.stateName,
      this.cityName,
      this.pincode,
      this.address,
      this.settlementPrice,
      this.settlementPriceType,
      this.landmark,
      this.finalPaymentStatus});

  GetOrderDetailsData.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
    orderToken = json['order_token'];
    orderDate = json['order_date'];
    orderApproveDate = json['order_approve_date'];
    orderShippedDate = json['order_shipped_date'];
    orderReceiveDate = json['order_receive_date'];
    orderCompleteDate = json['order_complete_date'];
    orderDeliverDate = json['order_deliver_date'];
    totalItem = json['total_item'];
    orderAmount = json['order_amount'];
    shippingAmount = json['shipping_amount'];
    finalOrderAmount = json['final_order_amount'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    pincode = json['pincode'];
    address = json['address'];
    landmark = json['landmark'];
    settlementPrice = json['settlement_price'];
    settlementPriceType = json['settlement_price_type'];
    finalPaymentStatus = json['final_payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_status'] = orderStatus;
    data['order_token'] = orderToken;
    data['order_date'] = orderDate;
    data['order_approve_date'] = orderApproveDate;
    data['order_shipped_date'] = orderShippedDate;
    data['order_receive_date'] = orderReceiveDate;
    data['order_complete_date'] = orderCompleteDate;
    data['order_deliver_date'] = orderDeliverDate;
    data['total_item'] = totalItem;
    data['order_amount'] = orderAmount;
    data['shipping_amount'] = shippingAmount;
    data['final_order_amount'] = finalOrderAmount;
    data['state_name'] = stateName;
    data['city_name'] = cityName;
    data['pincode'] = pincode;
    data['address'] = address;
    data['landmark'] = landmark;
    data['settlement_price'] = settlementPrice;
    data['settlement_price_type'] = settlementPriceType;
    data['final_payment_status'] = finalPaymentStatus;
    return data;
  }
}
