class ProfileDataModel {
  UserData? userData;

  ProfileDataModel({this.userData});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? companyType;
  String? mobileNumber;
  String? name;

  UserData({this.companyType, this.mobileNumber, this.name});

  UserData.fromJson(Map<String, dynamic> json) {
    companyType = json['company_type'];
    mobileNumber = json['mobileNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_type'] = companyType;
    data['mobileNumber'] = mobileNumber;
    data['name'] = name;
    return data;
  }
}
