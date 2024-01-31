class OrderPaymentDetailsModel {
  GetPaymentDetailsData? getPaymentDetailsData;
  String? paymentImagePath;
  String? qrImagePath;

  OrderPaymentDetailsModel(
      {this.getPaymentDetailsData, this.paymentImagePath, this.qrImagePath});

  OrderPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    getPaymentDetailsData = json['getPaymentDetailsData'] != null
        ? GetPaymentDetailsData.fromJson(json['getPaymentDetailsData'])
        : null;
    paymentImagePath = json['paymentImagePath'];
    qrImagePath = json['qrImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getPaymentDetailsData != null) {
      data['getPaymentDetailsData'] = getPaymentDetailsData!.toJson();
    }
    data['paymentImagePath'] = paymentImagePath;
    data['qrImagePath'] = qrImagePath;
    return data;
  }
}

class GetPaymentDetailsData {
  int? paymentType;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? micrCode;
  String? holderName;
  String? branch;
  String? upiId;
  String? qrCodeImage;
  String? payAmount;
  String? paymentImage;

  GetPaymentDetailsData(
      {this.paymentType,
      this.bankName,
      this.accountNumber,
      this.ifscCode,
      this.micrCode,
      this.holderName,
      this.branch,
      this.upiId,
      this.qrCodeImage,
      this.payAmount,
      this.paymentImage});

  GetPaymentDetailsData.fromJson(Map<String, dynamic> json) {
    paymentType = json['payment_type'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    micrCode = json['micr_code'];
    holderName = json['holder_name'];
    branch = json['branch'];
    upiId = json['upi_id'];
    qrCodeImage = json['qr_code_image'];
    payAmount = json['pay_amount'];
    paymentImage = json['payment_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_type'] = paymentType;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['micr_code'] = micrCode;
    data['holder_name'] = holderName;
    data['branch'] = branch;
    data['upi_id'] = upiId;
    data['qr_code_image'] = qrCodeImage;
    data['pay_amount'] = payAmount;
    data['payment_image'] = paymentImage;
    return data;
  }
}
