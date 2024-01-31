class PaymentMethodListModel {
  List<BankData>? bankData;
  List<UpiData>? upiData;
  List<QrData>? qrData;
  num? totalOrderAmount;
  num? totalOutstandingAmount;
  String? qrImagePath;

  PaymentMethodListModel(
      {this.bankData,
      this.upiData,
      this.qrData,
      this.totalOrderAmount,
      this.totalOutstandingAmount,
      this.qrImagePath});

  PaymentMethodListModel.fromJson(Map<String, dynamic> json) {
    if (json['bankData'] != null) {
      bankData = <BankData>[];
      json['bankData'].forEach((v) {
        bankData!.add(BankData.fromJson(v));
      });
    }
    if (json['upiData'] != null) {
      upiData = <UpiData>[];
      json['upiData'].forEach((v) {
        upiData!.add(UpiData.fromJson(v));
      });
    }
    if (json['qrData'] != null) {
      qrData = <QrData>[];
      json['qrData'].forEach((v) {
        qrData!.add(QrData.fromJson(v));
      });
    }
    totalOrderAmount = json['total_order_amount'];
    totalOutstandingAmount = json['total_outstanding_amount'];
    qrImagePath = json['qrImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bankData != null) {
      data['bankData'] = bankData!.map((v) => v.toJson()).toList();
    }
    if (upiData != null) {
      data['upiData'] = upiData!.map((v) => v.toJson()).toList();
    }
    if (qrData != null) {
      data['qrData'] = qrData!.map((v) => v.toJson()).toList();
    }
    data['total_order_amount'] = totalOrderAmount;
    data['total_outstanding_amount'] = totalOutstandingAmount;
    data['qrImagePath'] = qrImagePath;
    return data;
  }
}

class BankData {
  String? id;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? micrCode;
  String? holderName;
  String? branch;

  BankData(
      {this.id,
      this.bankName,
      this.accountNumber,
      this.ifscCode,
      this.micrCode,
      this.holderName,
      this.branch});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    micrCode = json['micr_code'];
    holderName = json['holder_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['micr_code'] = micrCode;
    data['holder_name'] = holderName;
    data['branch'] = branch;
    return data;
  }
}

class UpiData {
  String? id;
  String? upiId;

  UpiData({this.id, this.upiId});

  UpiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['upi_id'] = upiId;
    return data;
  }
}

class QrData {
  String? id;
  String? qrCodeImage;

  QrData({this.id, this.qrCodeImage});

  QrData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrCodeImage = json['qr_code_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qr_code_image'] = qrCodeImage;
    return data;
  }
}
