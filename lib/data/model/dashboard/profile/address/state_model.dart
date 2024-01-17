class StateModel {
  List<StateData>? stateData;

  StateModel({this.stateData});

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json['stateData'] != null) {
      stateData = <StateData>[];
      json['stateData'].forEach((v) {
        stateData!.add(StateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stateData != null) {
      data['stateData'] = stateData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateData {
  String? id;
  String? stateName;

  StateData({this.id, this.stateName});

  StateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state_name'] = stateName;
    return data;
  }
}
