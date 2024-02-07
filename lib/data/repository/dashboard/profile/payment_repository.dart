import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_payment_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_payment_list_model.dart';
import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../logic/services/preferences.dart';
import '../../../../utils/app_utils.dart';
import '../../../model/dashboard/profile/payment_method_list_model.dart';
import '../../../model/dashboard/profile/upload_image_resp_model.dart';

class PaymentRepository {
  final Api _api = Api();

  Future<PaymentMethodListModel?> getPaymentMethodList(
      {required String screenType, required String orderId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "screenType": screenType == AppStrings.fromCart ? "1" : "2",
      "orderId": screenType == AppStrings.fromCart ? "1" : orderId
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.paymentMethodLIst,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get payment method list response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get payment method list json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get payment method list realData $realData");
        return PaymentMethodListModel.fromJson(realData);
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<UploadImageResponseModel?> uploadPaymentScreenshot(
      {required FormData formData}) async {
    log("api response upload screenshot sent ${formData.fields}");
    try {
      Response response = await _api.sendRequest.post(
        ApiEndPoints.uploadScreenshot,
        data: formData,
        onSendProgress: (int sent, int total) {
          log("api response upload screenshot sent $sent");
          log("api response upload screenshot total $total");
        },
      );
      log("api response upload screenshot response ${jsonEncode(response.data)}");
      UploadImageResponseModel apiResponse = UploadImageResponseModel.fromJson(
          jsonDecode(jsonEncode(response.data)));
      log("api response upload screenshot json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        return apiResponse;
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

  Future<bool?> orderPlaceApi({required Map<String, dynamic> jsonData}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "orderToken": jsonData["orderToken"],
      "paymentImage": jsonData["paymentImage"],
      "payAmount": jsonData["payAmount"],
      "addressId": jsonData["addressId"] ?? "1",
      "PaymentType": jsonData["PaymentType"],
      "paymentId": jsonData["paymentId"],
      "shipping_amount": jsonData["shipping_amount"] ?? "0",
      "shipping_distance": jsonData["shipping_distance"] ?? "0"
    };
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.orderPlaced,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response order place api response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response order place api json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
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

  Future<OrderPaymentListModel?> getOrderPaymentListData(
      {required int offSetVal, required String paymentStatus}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "offsetValue": offSetVal,
      "paymentStatus": paymentStatus
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderPaymentList,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order payment list response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order payment list json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order payment list realData $realData");
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

  Future<OrderPaymentDetailsModel?> getOrderPaymentDetailsData(
      {required String paymentId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId, "id": paymentId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.orderPaymentDetails,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get order payment details response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get order payment details json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get order payment details realData $realData");
        return OrderPaymentDetailsModel.fromJson(realData);
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
