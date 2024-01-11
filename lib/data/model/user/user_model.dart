class UserModel {
  String? mobileNumber;
  String? id;
  bool? isActive;
  String? token;

  UserModel({this.mobileNumber, this.id, this.isActive, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    id = json['id'];
    isActive = json['isActive'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNumber'] = mobileNumber;
    data['id'] = id;
    data['isActive'] = isActive;
    data['token'] = token;
    return data;
  }
}
