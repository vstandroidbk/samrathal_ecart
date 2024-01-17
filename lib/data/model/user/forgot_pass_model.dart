class ForgotPasswordModel {
  OtpData? otpData;

  ForgotPasswordModel({this.otpData});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    otpData =
        json['otpData'] != null ? OtpData.fromJson(json['otpData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (otpData != null) {
      data['otpData'] = otpData!.toJson();
    }
    return data;
  }
}

class OtpData {
  int? otp;

  OtpData({this.otp});

  OtpData.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    return data;
  }
}
