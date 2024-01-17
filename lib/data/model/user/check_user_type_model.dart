class CheckUserTypeModel {
  CheckUserTypeData? userData;

  CheckUserTypeModel({this.userData});

  CheckUserTypeModel.fromJson(Map<String, dynamic> json) {
    userData = json['userData'] != null
        ? CheckUserTypeData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    return data;
  }
}

class CheckUserTypeData {
  int? userType;
  int? otp;

  CheckUserTypeData({this.userType, this.otp});

  CheckUserTypeData.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userType'] = userType;
    data['otp'] = otp;
    return data;
  }
}
