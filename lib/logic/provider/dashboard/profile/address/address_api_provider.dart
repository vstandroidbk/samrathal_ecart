import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/address_list_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/city_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/edit_address_data_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/state_model.dart';
import 'package:samrathal_ecart/data/repository/dashboard/profile/address_repository.dart';
import 'package:samrathal_ecart/widgets/navigate_anim.dart';
import '../../../../../core/api.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../presentation/dashboard/dashboard_screen.dart';
import '../../../../../utils/utils.dart';

class AddressApiProvider with ChangeNotifier {
  final AddressRepository _addressRepository = AddressRepository();

  // get state api call -------------->>
  bool _stateLoading = false;

  bool get stateLoading => _stateLoading;

  StateModel? _stateModel = StateModel();

  StateModel? get stateModel => _stateModel;

  setStateLoading(bool value) {
    _stateLoading = value;
    notifyListeners();
  }

  clearState() {
    _stateModel = null;
    notifyListeners();
  }

  Future<void> getStateApi() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setStateLoading(true);
    // Make the API call
    try {
      StateModel? stateModel = await _addressRepository.getState();
      log("api check User Type success ${stateModel?.stateData}");
      if (stateModel != null && stateModel.stateData != null) {
        _stateModel = stateModel;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setStateLoading(false);
    }
  }

  setStateLoaderFalse() {
    _stateLoading = false;
  }

  // get city api call ---->>
  bool _cityLoading = false;

  bool get cityLoading => _cityLoading;

  CityModel? _cityModel = CityModel();

  CityModel? get cityModel => _cityModel;

  setCityLoading(bool value) {
    _cityLoading = value;
    notifyListeners();
  }

  clearCity() {
    _cityModel = null;
    notifyListeners();
  }

  Future<void> getCityApi({required String stateId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setCityLoading(true);
    // Make the API call
    try {
      CityModel? cityModel = await _addressRepository.getCity(stateId: stateId);
      log("api check User Type success ${cityModel?.districtData}");
      if (cityModel != null && cityModel.districtData != null) {
        _cityModel = cityModel;
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setCityLoading(false);
    }
  }

  setCityLoaderFalse() {
    _cityLoading = false;
  }

  // add address api----------->>
  bool _addAddressLoading = false;

  bool get addAddressLoading => _addAddressLoading;

  setAddAddressLoading(bool value) {
    _addAddressLoading = value;
    notifyListeners();
  }

  Future<bool?> addAddress({
    required String stateId,
    required String cityId,
    required String address,
    required String zipCode,
    required String landMark,
    required String primaryStatus,
    required BuildContext context,
    required String fromScreen,
  }) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setAddAddressLoading(true);
    // Make the API call
    try {
      var addAddress = await _addressRepository.addAddress(
          stateId: stateId,
          cityId: cityId,
          address: address,
          zipCode: zipCode,
          landMark: landMark,
          primaryStatus: primaryStatus);
      if (addAddress != null && addAddress) {
        if (fromScreen == AppStrings.fromRegisterScreen) {
          Future.delayed(const Duration(milliseconds: 0), () {
            Navigator.pushAndRemoveUntil(
              context,
              FadeAnimatingRoute(
                route: const DashboardScreen(selectedTab: 0),
              ),
              (route) => false,
            );
          });
        }
      }
      log("api add address success $addAddress");
      return true;
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setAddAddressLoading(false);
    }
  }

  setAddAddressLoaderFalse() {
    _addAddressLoading = false;
  }

  // get address list api----------->>
  bool _getAddressLoading = false;

  bool get getAddressLoading => _getAddressLoading;

  AddressListModel? _addressListModel = AddressListModel();

  AddressListModel? get addressListModel => _addressListModel;

  setGetAddressLoading(bool value) {
    _getAddressLoading = value;
    notifyListeners();
  }

  Future<void> getAddressList() async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setGetAddressLoading(true);
    // Make the API call
    try {
      var getAddress = await _addressRepository.getAddressList();
      if (getAddress != null && getAddress.addressData != null) {
        _addressListModel = getAddress;
      }
      log("api get address list success $getAddress");
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setGetAddressLoading(false);
    }
  }

  setGetAddressLoaderFalse() {
    _getAddressLoading = false;
  }

  // get edit address data api----------->>
  bool _editAddressLoading = false;

  bool get editAddressLoading => _editAddressLoading;

  EditAddressDataModel? _editAddressDataModel = EditAddressDataModel();

  EditAddressDataModel? get editAddressDataModel => _editAddressDataModel;

  setEditAddressLoading(bool value) {
    _editAddressLoading = value;
    notifyListeners();
  }

  Future<void> getEditAddressData({required String addressId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setEditAddressLoading(true);
    // Make the API call
    try {
      var getAddress = await _addressRepository.getEditAddressData(addressId);
      if (getAddress != null && getAddress.addressData != null) {
        _editAddressDataModel = getAddress;
      }
      log("api get edit address data success $getAddress");
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setEditAddressLoading(false);
    }
  }

  setEditAddressLoaderFalse() {
    _editAddressLoading = false;
  }

  // update address api----------->>
  bool _updateAddressLoading = false;

  bool get updateAddressLoading => _updateAddressLoading;

  setUpdateAddressLoading(bool value) {
    _updateAddressLoading = value;
    notifyListeners();
  }

  Future<bool?> updateAddress({
    required String stateId,
    required String cityId,
    required String addressId,
    required String address,
    required String zipCode,
    required String landMark,
    required String primaryStatus,
    required BuildContext context,
  }) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setUpdateAddressLoading(true);
    // Make the API call
    try {
      var addAddress = await _addressRepository.updateAddress(
          stateId: stateId,
          cityId: cityId,
          address: address,
          zipCode: zipCode,
          landMark: landMark,
          primaryStatus: primaryStatus,
          addressId: addressId);
      getAddressList();
      // if (addAddress != null && addAddress) {
      //   Future.delayed(const Duration(milliseconds: 0), () {
      //     Navigator.pop(context);
      //   });
      // }
      log("api update address success $addAddress");
      return true;
    } catch (ex) {
      log("api update address error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setUpdateAddressLoading(false);
    }
  }

  setUpdateAddressLoaderFalse() {
    _updateAddressLoading = false;
  }

  // update primary address api----------->>
  bool _updatePrimaryAddressLoading = false;

  bool get updatePrimaryAddressLoading => _updatePrimaryAddressLoading;

  setUpdatePrimaryAddressLoading(bool value) {
    _updatePrimaryAddressLoading = value;
    notifyListeners();
  }

  Future<bool?> updatePrimaryAddress({
    required String addressId,
  }) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setUpdatePrimaryAddressLoading(true);
    // Make the API call
    try {
      var addAddress =
          await _addressRepository.updatePrimaryStatus(addressId: addressId);
      getAddressList();
      // if (addAddress != null && addAddress) {
      //   Future.delayed(const Duration(milliseconds: 0), () {
      //     Navigator.pop(context);
      //   });
      // }
      log("api update primary address success $addAddress");
      return true;
    } catch (ex) {
      log("api update primary address error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setUpdatePrimaryAddressLoading(false);
    }
  }

  setPrimaryAddressLoaderFalse() {
    _updatePrimaryAddressLoading = false;
  }

  setLoaderFalseDataNull() {
    setStateLoaderFalse();
    setCityLoaderFalse();
    setGetAddressLoaderFalse();
    setAddAddressLoaderFalse();
    setEditAddressLoaderFalse();
    setUpdateAddressLoaderFalse();
    _stateModel = null;
    _cityModel = null;
  }
}
