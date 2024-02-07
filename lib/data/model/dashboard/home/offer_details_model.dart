class OfferDetailsModel {
  OfferDetails? offerDetails;
  String? offerImagePath;
  int? offerOptStatus;

  OfferDetailsModel(
      {this.offerDetails, this.offerImagePath, this.offerOptStatus});

  OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    offerDetails = json['offerDetails'] != null
        ? OfferDetails.fromJson(json['offerDetails'])
        : null;
    offerImagePath = json['offerImagePath'];
    offerOptStatus = json['offer_opt_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offerDetails != null) {
      data['offerDetails'] = offerDetails!.toJson();
    }
    data['offerImagePath'] = offerImagePath;
    data['offer_opt_status'] = offerOptStatus;
    return data;
  }
}

class OfferDetails {
  String? id;
  String? title;
  String? offerImage;
  String? startDate;
  String? endDate;
  String? description;

  OfferDetails(
      {this.id,
      this.title,
      this.offerImage,
      this.startDate,
      this.endDate,
      this.description});

  OfferDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    offerImage = json['offer_image'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['offer_image'] = offerImage;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['description'] = description;
    return data;
  }
}
