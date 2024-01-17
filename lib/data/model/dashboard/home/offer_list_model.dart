class OfferListModel {
  List<OfferListData>? offerData;
  String? offerImagePath;

  OfferListModel({this.offerData, this.offerImagePath});

  OfferListModel.fromJson(Map<String, dynamic> json) {
    if (json['offerData'] != null) {
      offerData = <OfferListData>[];
      json['offerData'].forEach((v) {
        offerData!.add(OfferListData.fromJson(v));
      });
    }
    offerImagePath = json['offerImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offerData != null) {
      data['offerData'] = offerData!.map((v) => v.toJson()).toList();
    }
    data['offerImagePath'] = offerImagePath;
    return data;
  }
}

class OfferListData {
  String? id;
  String? offerImage;

  OfferListData({this.id, this.offerImage});

  OfferListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerImage = json['offer_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['offer_image'] = offerImage;
    return data;
  }
}
