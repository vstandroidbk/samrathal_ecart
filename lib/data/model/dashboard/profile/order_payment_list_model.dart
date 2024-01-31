class OrderPaymentListModel {
  List<PaymentList>? paymentList;

  OrderPaymentListModel({this.paymentList});

  OrderPaymentListModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentList'] != null) {
      paymentList = <PaymentList>[];
      json['paymentList'].forEach((v) {
        paymentList!.add(PaymentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentList != null) {
      data['paymentList'] = paymentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentList {
  String? id;
  String? orderId;
  dynamic orderNumber;
  int? paymentType;
  String? bankName;
  String? accountNumber;
  String? upiId;
  String? qrCodeImage;
  String? payAmount;
  String? paymentDate;
  String? orderToken;
  bool? paymentStatus;
  int? orderStatus;

  PaymentList(
      {this.id,
      this.orderId,
      this.orderNumber,
      this.paymentType,
      this.bankName,
      this.accountNumber,
      this.upiId,
      this.qrCodeImage,
      this.payAmount,
      this.paymentDate,
      this.orderToken,
      this.paymentStatus,
      this.orderStatus});

  PaymentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    orderNumber = json['order_number'];
    paymentType = json['payment_type'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    upiId = json['upi_id'];
    qrCodeImage = json['qr_code_image'];
    payAmount = json['pay_amount'];
    paymentDate = json['payment_date'];
    orderToken = json['order_token'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    data['order_number'] = orderNumber;
    data['payment_type'] = paymentType;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['upi_id'] = upiId;
    data['qr_code_image'] = qrCodeImage;
    data['pay_amount'] = payAmount;
    data['payment_date'] = paymentDate;
    data['order_token'] = orderToken;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    return data;
  }
}
