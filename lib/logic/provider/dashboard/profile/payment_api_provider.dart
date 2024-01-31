import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_payment_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_payment_list_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/payment_method_list_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/upload_image_resp_model.dart';
import 'package:samrathal_ecart/data/repository/dashboard/profile/payment_repository.dart';
import '../../../../core/api.dart';
import 'package:dio/dio.dart';
import '../../../../core/app_strings.dart';
import '../../../../presentation/dashboard/profile/payment/widget/payment_success_screen.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/navigate_anim.dart';

class PaymentApiProvider with ChangeNotifier {
  final PaymentRepository _paymentRepository = PaymentRepository();

  // get payment list data api call -------------->>
  bool _paymentMethodListLoading = false;

  bool get paymentMethodListLoading => _paymentMethodListLoading;

  PaymentMethodListModel? _paymentMethodListModel = PaymentMethodListModel();

  PaymentMethodListModel? get paymentMethodListModel => _paymentMethodListModel;

  setPaymentMethodListLoading(bool value) {
    _paymentMethodListLoading = value;
    notifyListeners();
  }

  Future<void> getPaymentMethodListApi(
      {required String screenType, String? orderId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setPaymentMethodListLoading(true);
    // Make the API call
    try {
      PaymentMethodListModel? paymentMethodListModel = await _paymentRepository
          .getPaymentMethodList(screenType: screenType, orderId: orderId ?? "");
      log("api get payment method list success ${paymentMethodListModel?.bankData}");
      if (paymentMethodListModel != null &&
          paymentMethodListModel.bankData != null) {
        _paymentMethodListModel = paymentMethodListModel;
      }
    } catch (ex) {
      log("api get payment method list error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setPaymentMethodListLoading(false);
    }
  }

  setPaymentMethodListNull() {
    _paymentMethodListLoading = false;
    _paymentMethodListModel = null;
  }

  // upload screenshot api call -------------->>
  bool _uploadImageLoading = false;

  bool get uploadImageLoading => _uploadImageLoading;

  UploadImageResponseModel? _uploadImageModel = UploadImageResponseModel();

  UploadImageResponseModel? get uploadImageModel => _uploadImageModel;

  setUploadImageLoading(bool value) {
    _uploadImageLoading = value;
    notifyListeners();
  }

  Future<void> uploadImageFromPayment({required FormData formData}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setUploadImageLoading(true);
    // Make the API call
    try {
      UploadImageResponseModel? uploadImageModel =
          await _paymentRepository.uploadPaymentScreenshot(formData: formData);
      log("api upload image success ${uploadImageModel?.data}");
      if (uploadImageModel != null && uploadImageModel.data != null) {
        _uploadImageModel = uploadImageModel;
      }
    } catch (ex) {
      log("api upload image error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setUploadImageLoading(false);
    }
  }

  setUploadImageDataNull() {
    _uploadImageLoading = false;
    _uploadImageModel = null;
  }

  clearImage() {
    _uploadImageLoading = false;
    _uploadImageModel = null;
    notifyListeners();
  }

  // order place api ------------>>
  bool _orderPlaceLoading = false;

  bool get orderPlaceLoading => _orderPlaceLoading;

  setOrderPlaceLoading(bool value) {
    _orderPlaceLoading = value;
    notifyListeners();
  }

  Future<bool> orderPlaceApi(
      {required Map<String, dynamic> jsonData,
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
      var orderPlaceStatus =
          await _paymentRepository.orderPlaceApi(jsonData: jsonData);
      log("api order place success $orderPlaceStatus");
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          FadeAnimatingRoute(
            route: const PaymentSuccessScreen(),
          ),
        );
      }
      return true;
    } catch (ex) {
      log("api order place error $ex");
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

  // get order payment list data api call -------------->>
  bool _orderPaymentListLoading = false;

  bool get orderPaymentListLoading => _orderPaymentListLoading;

  OrderPaymentListModel? _orderPaymentListModel = OrderPaymentListModel();

  OrderPaymentListModel? get orderPaymentListModel => _orderPaymentListModel;

  setOrderPaymentListLoading(bool value) {
    _orderPaymentListLoading = value;
    notifyListeners();
  }

  RefreshController orderPaymentListRefreshController =
      RefreshController(initialRefresh: false);

  List<PaymentList> orderPaymentListObj = [];
  int orderPaymentListCurrentPage = 1;

  void resetOrderPaymentListData() {
    orderPaymentListCurrentPage = 1;
    orderPaymentListObj.clear();
  }

  Future<void> getOrderPaymentListData(bool isRefresh) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    if (isRefresh) {
      setOrderPaymentListLoading(true);
    }
    // Make the API call
    try {
      OrderPaymentListModel? orderPaymentListModel = await _paymentRepository
          .getOrderPaymentListData(offSetVal: orderPaymentListCurrentPage);
      log("api get order PaymentList list success ${orderPaymentListModel?.paymentList}");
      if (orderPaymentListModel != null &&
          orderPaymentListModel.paymentList != null) {
        _orderPaymentListModel = orderPaymentListModel;
        orderPaymentListObj.addAll(orderPaymentListModel.paymentList!);
        orderPaymentListCurrentPage++;
        if (isRefresh) {
          orderPaymentListRefreshController.refreshCompleted();
        } else {
          orderPaymentListRefreshController.loadComplete();
        }
        notifyListeners();
      }
    } catch (ex) {
      _orderPaymentListModel = null;
      orderPaymentListRefreshController.loadFailed();
      log("api get order PaymentList list error $ex");
      Utils.showToast(ex.toString());
      notifyListeners();
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderPaymentListLoading(false);
      orderPaymentListRefreshController.loadComplete();
      notifyListeners();
    }
  }

  setOrderPaymentListNull() {
    _orderPaymentListLoading = false;
    _orderPaymentListModel = null;
  }

  // get order payment details data api call -------------->>
  bool _orderPaymentDetailsLoading = false;

  bool get orderPaymentDetailsLoading => _orderPaymentDetailsLoading;

  OrderPaymentDetailsModel? _orderPaymentDetailsModel =
      OrderPaymentDetailsModel();

  OrderPaymentDetailsModel? get orderPaymentDetailsModel =>
      _orderPaymentDetailsModel;

  setOrderPaymentDetailsLoading(bool value) {
    _orderPaymentDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getOrderPaymentDetailsData({required String paymentId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOrderPaymentDetailsLoading(true);
    // Make the API call
    try {
      OrderPaymentDetailsModel? orderPaymentDetailsModel =
          await _paymentRepository.getOrderPaymentDetailsData(
              paymentId: paymentId);
      log("api get order Payment details success ${orderPaymentDetailsModel?.getPaymentDetailsData}");
      if (orderPaymentDetailsModel != null &&
          orderPaymentDetailsModel.getPaymentDetailsData != null) {
        _orderPaymentDetailsModel = orderPaymentDetailsModel;
      }
    } catch (ex) {
      log("api get order Payment details error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderPaymentDetailsLoading(false);
    }
  }

  setOrderPaymentDetailsNull() {
    _orderPaymentDetailsLoading = false;
    _orderPaymentDetailsModel = null;
  }
}
