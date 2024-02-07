class WishListAddRemoveModel {
  int? wishlistStatus;

  WishListAddRemoveModel({this.wishlistStatus});

  WishListAddRemoveModel.fromJson(Map<String, dynamic> json) {
    wishlistStatus = json['wishlist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wishlist_status'] = wishlistStatus;
    return data;
  }
}
