import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/data/model/dashboard/wishlist/wishlist_add_remove_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/wishlist/wishlist_model.dart';
import 'package:samrathal_ecart/data/repository/dashboard/wishlist/wishlist_repository.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/dashboard_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/shop/shop_api_provider.dart';
import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../utils/app_utils.dart';

class WishlistApiProvider with ChangeNotifier {
  final WishlistRepository _wishlistRepository = WishlistRepository();

  // get wish list item api call -------------->>
  bool _wishListLoading = false;

  bool get wishListLoading => _wishListLoading;

  WishListModel? _wishListModel = WishListModel();

  WishListModel? get wishListModel => _wishListModel;

  setWishListLoading(bool value) {
    _wishListLoading = value;
    notifyListeners();
  }

  Future<void> getWishListApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setWishListLoading(true);
    // Make the API call
    try {
      WishListModel? wishListModel =
          await _wishlistRepository.getWishListItem();
      log("api wish list item data success ${wishListModel?.wishListData}");
      if (wishListModel != null && wishListModel.wishListData != null) {
        _wishListModel = wishListModel;
      }
    } catch (ex) {
      log("api wish list item data error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setWishListLoading(false);
    }
  }

  setWishListDataNull() {
    _wishListLoading = false;
    _wishListModel = null;
  }

  // add remove wish list item api call -------------->>
  bool _addRemoveWishListLoading = false;

  bool get addRemoveWishListLoading => _addRemoveWishListLoading;

  WishListAddRemoveModel? _wishListAddRemoveModel = WishListAddRemoveModel();

  WishListAddRemoveModel? get wishListAddRemoveModel => _wishListAddRemoveModel;

  setAddRemoveWishListLoading(bool value) {
    _addRemoveWishListLoading = value;
    notifyListeners();
  }

  Future<void> addRemoveWishListApi(
      {required String from,
      required String productId,
      required String wishStatus,
      required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setAddRemoveWishListLoading(true);
    // Make the API call
    try {
      WishListAddRemoveModel? wishListModel = await _wishlistRepository
          .addRemoveWishListItem(productId: productId, wishStatus: wishStatus);
      log("api add remove wish list success ${wishListModel?.wishlistStatus}");
      if (wishListModel != null && wishListModel.wishlistStatus != null) {
        _wishListAddRemoveModel = wishListModel;
        if (context.mounted) {
          if (from == AppStrings.fromHome) {
            Provider.of<DashboardApiProvider>(context, listen: false)
                .getDashboardDataApi();
          } else if (from == AppStrings.fromProductList) {
            Provider.of<ShopApiProvider>(context, listen: false)
                .getProductListApi();
          } else if (from == AppStrings.fromProductDetails) {
            Provider.of<ShopApiProvider>(context, listen: false)
                .getProductDetailsApi(productId: productId);
            Provider.of<DashboardApiProvider>(context, listen: false)
                .getDashboardDataApi();
            Provider.of<ShopApiProvider>(context, listen: false)
                .getProductListApi();
          } else if (from == AppStrings.fromWishList) {
            Provider.of<WishlistApiProvider>(context, listen: false)
                .getWishListApi();
          }
        }
      }
    } catch (ex) {
      log("api add remove wish list error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setAddRemoveWishListLoading(false);
    }
  }

  setAddRemoveWishListDataNull() {
    _addRemoveWishListLoading = false;
    _wishListAddRemoveModel = null;
  }
}
