import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_details_model.dart';
import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../logic/services/preferences.dart';
import '../../../../utils/app_utils.dart';
import '../../../model/dashboard/profile/order_item_details_model.dart';
import '../../../model/dashboard/profile/order_list_model.dart';
import '../../../model/dashboard/profile/order_payment_list_model.dart';

class OrderRepository {
  final Api _api = Api();

  Future<OrderListModel?> getOrderListData(
      {required int offSetVal, required String orderStatus}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "offsetValue": offSetVal,
      "orderStatus": orderStatus
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderListData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order list response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order list json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order list realData $realData");
        return OrderListModel.fromJson(realData);
      }
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw e.response!.data["message"];
          case 401:
            throw e.response!.data["message"];
          default:
            throw "Something went wrong..";
        }
      } else {
        throw "Something went wrong..";
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<OrderDetailsModel?> getOrderDetailsData(
      {required String orderId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId, "orderPrimaryId": orderId};
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.orderDetails,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order details response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order details json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order details realData $realData");
        return OrderDetailsModel.fromJson(realData);
      }
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw e.response!.data["message"];
          case 401:
            throw e.response!.data["message"];
          default:
            throw "Something went wrong..";
        }
      } else {
        throw "Something went wrong..";
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<OrderItemDetailsModel?> getOrderItemDetails(
      {required String orderId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId, "orderPrimaryId": orderId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderItemDetails,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order item details response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order item details json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order item details realData $realData");
        return OrderItemDetailsModel.fromJson(realData);
      }
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw e.response!.data["message"];
          case 401:
            throw e.response!.data["message"];
          default:
            throw "Something went wrong..";
        }
      } else {
        throw "Something went wrong..";
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<bool?> receiveOrder(
      {required String mobile,
      required String orderId,
      required String otp}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "mobileNumber": mobile,
      "otp": otp,
      "user_id": userId,
      "orderId": orderId
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderReceiveVerify,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response receive order OTP verify response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response receive order OTP verify json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response receive order OTP verify realData $realData");
      }
      return true;
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw e.response!.data["message"];
          case 401:
            throw e.response!.data["message"];
          default:
            throw "Something went wrong..";
        }
      } else {
        throw "Something went wrong..";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderPaymentListModel?> getOrderPaymentHistoryList(
      {required int offSetVal,
      required String paymentStatus,
      required String orderId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "offsetValue": offSetVal,
      "paymentStatus": paymentStatus,
      "orderId": orderId
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderPaymentHistoryList,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order payment history list response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order payment history list json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order payment history list realData $realData");
        return OrderPaymentListModel.fromJson(realData);
      }
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw e.response!.data["message"];
          case 401:
            throw e.response!.data["message"];
          default:
            throw "Something went wrong..";
        }
      } else {
        throw "Something went wrong..";
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
