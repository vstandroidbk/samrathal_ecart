import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../data/model/dashboard/shop/product_details_model.dart';
import '../../../../data/model/dashboard/shop/product_list_model.dart';
import '../../../../data/repository/dashboard/shop/shop_repository.dart';
import '../../../../utils/app_utils.dart';

class ShopApiProvider with ChangeNotifier {
  final ShopRepository _shopRepository = ShopRepository();

  // get product list data api -------------->>
  bool _productListLoading = false;

  bool get productListLoading => _productListLoading;

  ProductListModel? _productListModel = ProductListModel();

  ProductListModel? get productListModel => _productListModel;

  setProductListLoading(bool value) {
    _productListLoading = value;
    notifyListeners();
  }

  Future<void> getProductListApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setProductListLoading(true);
    // Make the API call
    try {
      ProductListModel? productListData =
          await _shopRepository.getProductListData();
      log("api get product list data success ${productListData?.productListData}");
      if (productListData != null && productListData.productListData != null) {
        _productListModel = productListData;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setProductListLoading(false);
    }
  }

  setProductListLoaderFalse() {
    _productListLoading = false;
  }

  setProductListDataNull() {
    setProductListLoaderFalse();
    _productListModel = null;
  }

  // get product details data api -------------->>
  bool _productDetailsLoading = false;

  bool get productDetailsLoading => _productDetailsLoading;

  ProductDetailsModel? _productDetailsModel = ProductDetailsModel();

  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  setProductDetailsLoading(bool value) {
    _productDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getProductDetailsApi({required String productId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setProductDetailsLoading(true);
    // Make the API call
    try {
      ProductDetailsModel? productDetailsData =
          await _shopRepository.getProductDetailsData(productId: productId);
      log("api get product details data success ${productDetailsData?.productDetails}");
      if (productDetailsData != null &&
          productDetailsData.productDetails != null) {
        _productDetailsModel = productDetailsData;
      }
    } catch (ex) {
      log("api get product details data error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setProductDetailsLoading(false);
    }
  }

  setProductDetailsLoaderFalse() {
    _productDetailsLoading = false;
  }

  setProductDetailsDataNull() {
    setProductDetailsLoaderFalse();
    _productDetailsModel = null;
  }
}
