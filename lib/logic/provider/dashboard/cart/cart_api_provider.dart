import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/dashboard_api_provider.dart';

import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../data/model/dashboard/cart/cart_item_details_model.dart';
import '../../../../data/model/dashboard/cart/cart_item_list_model.dart';
import '../../../../data/repository/dashboard/cart/cart_repository.dart';
import '../../../../presentation/dashboard/profile/payment/widget/payment_success_screen.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/navigate_anim.dart';
import '../shop/shop_api_provider.dart';

class CartApiProvider with ChangeNotifier {
  final CartRepository _cartRepository = CartRepository();

  // add to cart------------>>
  bool _addCartLoading = false;

  bool get addCartLoading => _addCartLoading;

  setAddCartLoading(bool value) {
    _addCartLoading = value;
    notifyListeners();
  }

  Future<bool> addToCart(
      {required String productId,
      required List<Map<String, dynamic>> addCartData,
      required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setAddCartLoading(true);
    // Make the API call
    try {
      var addCartStatus = await _cartRepository.addProductToCart(
          productId: productId, addCartData: addCartData);
      log("api add cart data success $addCartStatus");
      if (context.mounted) {
        Provider.of<ShopApiProvider>(context, listen: false)
            .getProductDetailsApi(productId: productId);
        Provider.of<DashboardApiProvider>(context, listen: false)
            .getCartCount();
      }
      return true;
    } catch (ex) {
      log("api add cart data error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setAddCartLoading(false);
    }
  }

  setAddCartLoaderFalse() {
    _addCartLoading = false;
  }

  // get cart list item api call -------------->>
  bool _cartListLoading = false;

  bool get cartListLoading => _cartListLoading;

  CartItemListModel? _cartListModel = CartItemListModel();

  CartItemListModel? get cartListModel => _cartListModel;

  setCartListLoading(bool value) {
    _cartListLoading = value;
    notifyListeners();
  }

  Future<void> getCartListApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setCartListLoading(true);
    // Make the API call
    try {
      CartItemListModel? cartItemListModel =
          await _cartRepository.getCartListItem();
      log("api cart list item data success ${cartItemListModel?.cartData}");
      if (cartItemListModel != null && cartItemListModel.cartData != null) {
        _cartListModel = cartItemListModel;
      }
    } catch (ex) {
      log("api cart list item data error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setCartListLoading(false);
    }
  }

  setCartListDataNull() {
    _cartListLoading = false;
    _cartListModel = null;
  }

  // get cart item details api call -------------->>
  bool _cartItemDetailsLoading = false;

  bool get cartItemDetailsLoading => _cartItemDetailsLoading;

  CartItemDetailsModel? _cartItemDetailsModel = CartItemDetailsModel();

  CartItemDetailsModel? get cartItemDetailsModel => _cartItemDetailsModel;

  setCartItemDetailsLoading(bool value) {
    _cartItemDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getCartItemDetailsApi({required String productId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setCartItemDetailsLoading(true);
    // Make the API call
    try {
      CartItemDetailsModel? cartItemDetailsModel =
          await _cartRepository.getCartItemDetails(productId: productId);
      log("api cart item details data success ${cartItemDetailsModel?.itemData}");
      if (cartItemDetailsModel != null &&
          cartItemDetailsModel.itemData != null) {
        _cartItemDetailsModel = cartItemDetailsModel;
      }
    } catch (ex) {
      log("api cart item details data error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setCartItemDetailsLoading(false);
    }
  }

  setCartDetailsDataNull() {
    _cartItemDetailsLoading = false;
    _cartItemDetailsModel = null;
  }

  // update cart items------------>>
  bool _updateCartLoading = false;

  bool get updateCartLoading => _updateCartLoading;

  setUpdateCartLoading(bool value) {
    _updateCartLoading = value;
    notifyListeners();
  }

  Future<bool> updateCartItem(
      {required String productId,
      required List<Map<String, dynamic>> addCartData,
      required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setUpdateCartLoading(true);
    // Make the API call
    try {
      var addCartStatus = await _cartRepository.updateCartItem(
          productId: productId, addCartData: addCartData);
      log("api update cart success $addCartStatus");
      if (context.mounted) {
        Provider.of<CartApiProvider>(context, listen: false).getCartListApi();
      }
      return true;
    } catch (ex) {
      log("api update cart error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setUpdateCartLoading(false);
    }
  }

  setUpdateCartLoaderFalse() {
    _updateCartLoading = false;
  }

  // remove from cart------------>>
  bool _removeCartLoading = false;

  bool get removeCartLoading => _removeCartLoading;

  setRemoveCartLoading(bool value) {
    _removeCartLoading = value;
    notifyListeners();
  }

  Future<bool> removeFromCart(
      {required String productId, required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setRemoveCartLoading(true);
    // Make the API call
    try {
      var addCartStatus =
          await _cartRepository.removeCartItem(productId: productId);
      log("api remove cart data $addCartStatus");
      if (context.mounted) {
        Provider.of<CartApiProvider>(context, listen: false).getCartListApi();
        Provider.of<DashboardApiProvider>(context, listen: false)
            .getCartCount();
      }
      return true;
    } catch (ex) {
      log("api remove cart error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setRemoveCartLoading(false);
    }
  }

  setRemoveCartLoaderFalse() {
    _removeCartLoading = false;
  }

  // cod order place api ------------>>
  bool _orderPlaceLoading = false;

  bool get orderPlaceLoading => _orderPlaceLoading;

  setOrderPlaceLoading(bool value) {
    _orderPlaceLoading = value;
    notifyListeners();
  }

  Future<bool> orderPlaceApi(
      {required String addressId,
      num? distance,
      num? shippingCharge,
      required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setOrderPlaceLoading(true);
    // Make the API call
    try {
      var orderPlaceStatus = await _cartRepository.codOrderPlaceApi(
          addressId: addressId,
          distance: distance,
          shippingCharge: shippingCharge);
      log("api cod order place success $orderPlaceStatus");
      return true;
    } catch (ex) {
      log("api cod order place error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderPlaceLoading(false);
    }
  }

  setOrderPlaceLoaderFalse() {
    _orderPlaceLoading = false;
  }
}
