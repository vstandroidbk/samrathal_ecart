class AddressListModel {
  List<AddressData>? addressData;

  AddressListModel({this.addressData});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['addressData'] != null) {
      addressData = <AddressData>[];
      json['addressData'].forEach((v) {
        addressData!.add(AddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressData != null) {
      data['addressData'] = addressData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressData {
  String? id;
  String? address;
  int? zipCode;
  String? landmark;
  int? primaryStatus;
  StateData? stateData;
  DistrictData? districtData;

  AddressData(
      {this.id,
      this.address,
      this.zipCode,
      this.landmark,
      this.primaryStatus,
      this.stateData,
      this.districtData});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    primaryStatus = json['primary_status'];
    stateData = json['stateData'] != null
        ? StateData.fromJson(json['stateData'])
        : null;
    districtData = json['districtData'] != null
        ? DistrictData.fromJson(json['districtData'])
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

class StateData {
  String? stateName;

  StateData({this.stateName});

  StateData.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_name'] = stateName;
    return data;
  }
}

class DistrictData {
  String? districtName;

  DistrictData({this.districtName});

  DistrictData.fromJson(Map<String, dynamic> json) {
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district_name'] = districtName;
    return data;
  }
}
