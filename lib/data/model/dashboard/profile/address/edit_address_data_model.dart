class EditAddressDataModel {
  EditAddressData? addressData;

  EditAddressDataModel({this.addressData});

  EditAddressDataModel.fromJson(Map<String, dynamic> json) {
    addressData = json['addressData'] != null
        ? EditAddressData.fromJson(json['addressData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressData != null) {
      data['addressData'] = addressData!.toJson();
    }
    return data;
  }
}

class EditAddressData {
  String? stateId;
  String? districtId;
  String? address;
  String? landmark;
  int? zipCode;
  int? primaryStatus;

  EditAddressData(
      {this.stateId,
      this.districtId,
      this.address,
      this.landmark,
      this.zipCode,
      this.primaryStatus});

  EditAddressData.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    districtId = json['districtId'];
    address = json['address'];
    landmark = json['landmark'];
    zipCode = json['zip_code'];
    primaryStatus = json['primary_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stateId'] = stateId;
    data['districtId'] = districtId;
    data['address'] = address;
    data['landmark'] = landmark;
    data['zip_code'] = zipCode;
    data['primary_status'] = primaryStatus;
    return data;
  }
}
