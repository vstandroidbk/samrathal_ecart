class UploadImageResponseModel {
  String? status;
  String? message;
  Data? data;

  UploadImageResponseModel({this.status, this.message, this.data});

  UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? paymentImagePath;
  String? filename;

  Data({this.paymentImagePath, this.filename});

  Data.fromJson(Map<String, dynamic> json) {
    paymentImagePath = json['paymentImagePath'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentImagePath'] = paymentImagePath;
    data['filename'] = filename;
    return data;
  }
}
