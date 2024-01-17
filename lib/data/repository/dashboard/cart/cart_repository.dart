import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/cart/cart_item_details_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/cart/cart_item_list_model.dart';
import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../logic/services/preferences.dart';
import '../../../../utils/utils.dart';

class CartRepository {
  final Api _api = Api();

  Future<bool?> addProductToCart(
      {required String productId,
      required List<Map<String, dynamic>> addCartData}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "productId": productId,
      "cartData": addCartData,
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.addProductToCart,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response add product to cart response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response add product to cart json ${apiResponse.data}");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
    } catch (ex) {
      rethrow;
    }
  }

  Future<CartItemListModel?> getCartListItem() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.listCartItem,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get cart list item response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get cart list item json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get cart list item realData $realData");
        return CartItemListModel.fromJson(realData);
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

  Future<CartItemDetailsModel?> getCartItemDetails({required String productId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "productId": productId
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.addProductToCart,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get cart item details response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get cart item details json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get cart item details realData $realData");
        return CartItemDetailsModel.fromJson(realData);
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

  Future<bool?> updateCartItem(
      {required String productId,
      required List<Map<String, dynamic>> addCartData}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "productId": productId,
      "cartData": addCartData,
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.updateCartItem,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response update cart item response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response update cart item json ${apiResponse.data}");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool?> removeCartItem({required String productId}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId, "productId": productId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.removeCartItem,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response remove cart item response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response remove cart item json ${apiResponse.data}");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
    } catch (ex) {
      rethrow;
    }
  }
}
