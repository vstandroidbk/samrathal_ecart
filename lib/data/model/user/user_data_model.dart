class UserDataModel {
  UserData? userData;

  UserDataModel({this.userData});

  UserDataModel.fromJson(Map<String, dynamic> json) {
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
  String? mobileNumber;
  String? userId;
  bool? isActive;

  UserData({this.mobileNumber, this.userId, this.isActive});

  UserData.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    userId = json['user_id'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['user_id'] = userId;
    data['isActive'] = isActive;
    return data;
  }
}
