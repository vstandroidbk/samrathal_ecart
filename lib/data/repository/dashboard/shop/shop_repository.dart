import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/shop/product_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/shop/product_list_model.dart';
import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../logic/services/preferences.dart';

class ShopRepository {
  final Api _api = Api();

  Future<ProductListModel?> getProductListData() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getProductListData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get product list data response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get product list data json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get product list data realData $realData");
        return ProductListModel.fromJson(realData);
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

  Future<ProductDetailsModel?> getProductDetailsData(
      {required String productId}) async {
    var jsonBody = {"productId": productId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getProductDetailsData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get product details response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get product details json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get product details realData $realData");
        return ProductDetailsModel.fromJson(realData);
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
}
