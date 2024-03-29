import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../utils/app_utils.dart';
import '../../../data/model/dashboard/cart/cart_count_model.dart';
import '../../../data/model/dashboard/dashboard_data_model.dart';
import '../../../data/model/dashboard/profile/profile_data_model.dart';
import '../../../data/repository/dashboard/dashboard_repository.dart';

class DashboardApiProvider with ChangeNotifier {
  final DashboardRepository _dashboardRepository = DashboardRepository();

  // get profile data api call -------------->>
  bool _profileLoading = false;

  bool get profileLoading => _profileLoading;

  ProfileDataModel? _profileDataModel = ProfileDataModel();

  ProfileDataModel? get profileDataModel => _profileDataModel;

  setProfileDataLoading(bool value) {
    _profileLoading = value;
    notifyListeners();
  }

  Future<void> getProfileDataApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setProfileDataLoading(true);
    // Make the API call
    try {
      ProfileDataModel? profileDataModel =
          await _dashboardRepository.getProfileData();
      log("api get profile data success ${profileDataModel?.userData}");
      if (profileDataModel != null && profileDataModel.userData != null) {
        _profileDataModel = profileDataModel;
      }
    } catch (ex) {
      log("api get profile data error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setProfileDataLoading(false);
    }
  }

  setProfileLoaderFalse() {
    _profileLoading = false;
  }

  setProfileDataNull() {
    setProfileLoaderFalse();
    _profileDataModel = null;
  }

  // get dashboard data api call -------------->>
  bool _dashboardLoading = false;

  bool get dashboardLoading => _dashboardLoading;

  DashboardDataModel? _dashboardDataModel = DashboardDataModel();

  DashboardDataModel? get dashboardDataModel => _dashboardDataModel;

  setDashboardLoading(bool value) {
    _dashboardLoading = value;
    notifyListeners();
  }

  Future<void> getDashboardDataApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setDashboardLoading(true);
    // Make the API call
    try {
      DashboardDataModel? dashboardData =
          await _dashboardRepository.getDashboardData();
      log("api check User Type success ${dashboardData?.sliderImagePath}");
      if (dashboardData != null) {
        _dashboardDataModel = dashboardData;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setDashboardLoading(false);
    }
  }

  setDashboardLoaderFalse() {
    _dashboardLoading = false;
  }

  setDashboardDataNull() {
    setDashboardLoaderFalse();
    _dashboardDataModel = null;
  }

  // get cart count api call -------------->>
  bool _cartCountLoading = false;

  bool get cartCountLoading => _cartCountLoading;

  CartCountModel? _cartCountModel = CartCountModel();

  CartCountModel? get cartCountModel => _cartCountModel;

  setCartCountLoading(bool value) {
    _cartCountLoading = value;
    notifyListeners();
  }

  Future<void> getCartCount() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setCartCountLoading(true);
    // Make the API call
    try {
      CartCountModel? cartCountModel =
          await _dashboardRepository.getCartItemCount();
      log("api get cart count success ${cartCountModel?.cartCount}");
      if (cartCountModel != null && cartCountModel.cartCount != null) {
        _cartCountModel = cartCountModel;
      }
    } catch (ex) {
      log("api get cart count error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setCartCountLoading(false);
    }
  }

  setCartCountDataNull() {
    _cartCountLoading = false;
    _cartCountModel = null;
  }

  // update password api call ---->>
  bool _updatePassLoading = false;

  bool get updatePassLoading => _updatePassLoading;

  setUpdatePassLoading(bool value) {
    _updatePassLoading = value;
    notifyListeners();
  }

  Future<void> updatePassword(
      {required String oldPass,
      required BuildContext context,
      required String newPass}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setUpdatePassLoading(true);
    // Make the API call
    try {
      var changePass = await _dashboardRepository.updatePassword(
          oldPassword: oldPass, newPassword: newPass);
      if (changePass != null && changePass) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pop(context);
        });
      }
      log("api update password success $changePass");
    } catch (ex) {
      log("api update password error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setUpdatePassLoading(false);
    }
  }

  setUpdatePassLoaderFalse() {
    _updatePassLoading = false;
  }
}
