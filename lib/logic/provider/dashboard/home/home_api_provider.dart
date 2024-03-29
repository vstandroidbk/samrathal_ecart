import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../data/model/dashboard/home/offer_details_model.dart';
import '../../../../data/model/dashboard/home/offer_list_model.dart';
import '../../../../data/repository/dashboard/home/home_repository.dart';
import '../../../../utils/app_utils.dart';

class HomeApiProvider with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();

  // get product list data api -------------->>
  bool _offerListLoading = false;

  bool get offerListLoading => _offerListLoading;

  OfferListModel? _offerListModel = OfferListModel();

  OfferListModel? get offerListModel => _offerListModel;

  setOfferListLoading(bool value) {
    _offerListLoading = value;
    notifyListeners();
  }

  Future<void> getOfferListApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOfferListLoading(true);
    // Make the API call
    try {
      OfferListModel? offerListData = await _homeRepository.getOfferListData();
      log("api get offer list data success ${offerListData?.offerData}");
      if (offerListData != null && offerListData.offerData != null) {
        _offerListModel = offerListData;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOfferListLoading(false);
    }
  }

  setOfferListLoaderFalse() {
    _offerListLoading = false;
  }

  setOfferListDataNull() {
    setOfferListLoaderFalse();
    _offerListModel = null;
  }

  // get product details data api -------------->>
  bool _offerDetailsLoading = false;

  bool get offerDetailsLoading => _offerDetailsLoading;

  OfferDetailsModel? _offerDetailsModel = OfferDetailsModel();

  OfferDetailsModel? get offerDetailsModel => _offerDetailsModel;

  setOfferDetailsLoading(bool value) {
    _offerDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getOfferDetailsApi({required String offerId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOfferDetailsLoading(true);
    // Make the API call
    try {
      OfferDetailsModel? offerDetailsData =
          await _homeRepository.getOfferDetailsData(offerId: offerId);
      log("api get offer details data success ${offerDetailsData?.offerDetails}");
      if (offerDetailsData != null && offerDetailsData.offerDetails != null) {
        _offerDetailsModel = offerDetailsData;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOfferDetailsLoading(false);
    }
  }

  setProductDetailsLoaderFalse() {
    _offerDetailsLoading = false;
  }

  setOfferDetailsDataNull() {
    setProductDetailsLoaderFalse();
    _offerDetailsModel = null;
  }

  // opt offer api call ---->>
  bool _optOfferLoading = false;

  bool get optOfferLoading => _optOfferLoading;

  setOptOfferLoading(bool value) {
    _optOfferLoading = value;
    notifyListeners();
  }

  Future<void> optOfferApi(
      {required String offerId, required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOptOfferLoading(true);
    // Make the API call
    try {
      var changePass = await _homeRepository.optOfferApi(offerId: offerId);
      if (changePass != null && changePass) {
        if (context.mounted) {
          Provider.of<HomeApiProvider>(context, listen: false)
              .getOfferDetailsApi(offerId: offerId);
        }
      }
      log("api opt offer success $changePass");
    } catch (ex) {
      log("api opt offer error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOptOfferLoading(false);
    }
  }

  setOptOfferFalse() {
    _optOfferLoading = false;
  }
}
