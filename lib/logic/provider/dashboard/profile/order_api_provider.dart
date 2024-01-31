import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_item_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_list_model.dart';
import 'package:samrathal_ecart/data/repository/dashboard/profile/order_repository.dart';
import '../../../../core/api.dart';
import '../../../../core/app_strings.dart';
import '../../../../data/repository/auth/auth_repository.dart';
import '../../../../presentation/dashboard/profile/order/receive_order_verify_otp.dart';
import '../../../../presentation/dashboard/profile/order/widget/order_success_screen.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/navigate_anim.dart';

class OrderApiProvider with ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();
  final AuthRepository _userRepository = AuthRepository();

  // get order list data api call -------------->>
  bool _orderListLoading = false;

  bool get orderListLoading => _orderListLoading;

  OrderListModel? _orderListModel = OrderListModel();

  OrderListModel? get orderListModel => _orderListModel;

  setOrderListLoading(bool value) {
    _orderListLoading = value;
    notifyListeners();
  }

  RefreshController orderHistoryListRefreshController =
      RefreshController(initialRefresh: false);

  List<GetOrderData> orderHistoryListObj = [];
  int orderListCurrentPage = 1;

  void resetOrderHistoryListData() {
    orderListCurrentPage = 1;
    orderHistoryListObj.clear();
  }

  Future<void> getOrderListData(bool isRefresh) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    if (isRefresh) {
      setOrderListLoading(true);
    }
    // Make the API call
    try {
      OrderListModel? orderListModel = await _orderRepository.getOrderListData(
          offSetVal: orderListCurrentPage);
      log("api get order list success ${orderListModel?.getOrderData}");
      if (orderListModel != null && orderListModel.getOrderData != null) {
        _orderListModel = orderListModel;
        orderHistoryListObj.addAll(orderListModel.getOrderData!);
        orderListCurrentPage++;
        if (isRefresh) {
          orderHistoryListRefreshController.refreshCompleted();
        } else {
          orderHistoryListRefreshController.loadComplete();
        }
        notifyListeners();
      }
    } catch (ex) {
      _orderListModel = null;
      orderHistoryListRefreshController.loadFailed();
      log("api get order list error $ex");
      Utils.showToast(ex.toString());
      notifyListeners();
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderListLoading(false);
      notifyListeners();
    }
  }

  setOrderListNull() {
    _orderListLoading = false;
    _orderListModel = null;
  }

  // get order details data api call -------------->>
  bool _orderDetailsLoading = false;

  bool get orderDetailsLoading => _orderDetailsLoading;

  OrderDetailsModel? _orderDetailsModel = OrderDetailsModel();

  OrderDetailsModel? get orderDetailsModel => _orderDetailsModel;

  setOrderDetailsLoading(bool value) {
    _orderDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getOrderDetailsData({required String orderId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOrderDetailsLoading(true);
    // Make the API call
    try {
      OrderDetailsModel? orderDetailsModel =
          await _orderRepository.getOrderDetailsData(orderId: orderId);
      log("api get order details success ${orderDetailsModel?.getOrderDetailsData}");
      if (orderDetailsModel != null &&
          orderDetailsModel.getOrderDetailsData != null) {
        _orderDetailsModel = orderDetailsModel;
      }
    } catch (ex) {
      log("api get order details error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderDetailsLoading(false);
    }
  }

  setOrderDetailsNull() {
    _orderDetailsLoading = false;
    _orderDetailsModel = null;
  }

  // get order item details data api call -------------->>
  bool _orderItemDetailsLoading = false;

  bool get orderItemDetailsLoading => _orderItemDetailsLoading;

  OrderItemDetailsModel? _orderItemDetailsModel = OrderItemDetailsModel();

  OrderItemDetailsModel? get orderItemDetailsModel => _orderItemDetailsModel;

  setOrderItemDetailsLoading(bool value) {
    _orderItemDetailsLoading = value;
    notifyListeners();
  }

  Future<void> getOrderItemDetailsData({required String orderId}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setOrderItemDetailsLoading(true);
    // Make the API call
    try {
      OrderItemDetailsModel? orderItemDetailsModel =
          await _orderRepository.getOrderItemDetails(orderId: orderId);
      log("api get order item details success ${orderItemDetailsModel?.getOrderData}");
      if (orderItemDetailsModel != null &&
          orderItemDetailsModel.getOrderData != null) {
        _orderItemDetailsModel = orderItemDetailsModel;
      }
    } catch (ex) {
      log("api get order item details error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setOrderItemDetailsLoading(false);
    }
  }

  setOrderItemDetailsNull() {
    _orderItemDetailsLoading = false;
    _orderItemDetailsModel = null;
  }

  // resend otp api call ---->>
  bool _sendOtpLoading = false;

  bool get sendOtpLoading => _sendOtpLoading;

  setResendOtpLoading(bool value) {
    _sendOtpLoading = value;
    notifyListeners();
  }

  Future<bool> resendOtp(
      {required String mobile,
      required String orderId,
      required BuildContext context,
      int? userType}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setResendOtpLoading(true);
    // Make the API call
    try {
      var sendOtp = await _userRepository.resendOtp(mobile: mobile);
      if (sendOtp != null && sendOtp) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.push(
            context,
            FadeAnimatingRoute(
              route: ReceiveOrderVerifyOtp(
                mobileNo: mobile,
                orderId: orderId,
              ),
            ),
          );
        });
      }
      log("api verify OTP success");
      return true;
    } catch (ex) {
      log("api verify OTP error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setResendOtpLoading(false);
    }
  }

  setResendOtpFalse() {
    _sendOtpLoading = false;
  }

  // receive order otp verify api call ---->>
  bool _receiveOrderLoading = false;

  bool get receiveOrderLoading => _receiveOrderLoading;

  setReceiveOrderLoading(bool value) {
    _receiveOrderLoading = value;
    notifyListeners();
  }

  Future<bool> receiveOrder(
      {required String mobile,
      required String orderId,
      required String otp,
      required BuildContext context}) async {
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setReceiveOrderLoading(true);
    // Make the API call
    try {
      var sendOtp = await _orderRepository.receiveOrder(
          mobile: mobile, orderId: orderId, otp: otp);
      if (sendOtp != null && sendOtp) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushReplacement(
            context,
            FadeAnimatingRoute(
              route: const OrderSuccessScreen(),
            ),
          );
        });
      }
      log("api  receive order otp verify success");
      return true;
    } catch (ex) {
      log("api verify OTP error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setReceiveOrderLoading(false);
    }
  }

  setReceiveOrderFalse() {
    _receiveOrderLoading = false;
  }
}
