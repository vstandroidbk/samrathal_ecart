class CityModel {
  List<DistrictData>? districtData;

  CityModel({this.districtData});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['districtData'] != null) {
      districtData = <DistrictData>[];
      json['districtData'].forEach((v) {
        districtData!.add(DistrictData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (districtData != null) {
      data['districtData'] = districtData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictData {
  String? id;
  String? districtName;

  DistrictData({this.id, this.districtName});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['district_name'] = districtName;
    return data;
  }
}
