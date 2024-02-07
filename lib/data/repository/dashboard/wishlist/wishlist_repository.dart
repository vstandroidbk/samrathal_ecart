import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/wishlist/wishlist_add_remove_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/wishlist/wishlist_model.dart';
import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../logic/services/preferences.dart';
import '../../../../utils/app_utils.dart';

class WishlistRepository {
  final Api _api = Api();

  Future<WishListModel?> getWishListItem() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.wishList,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get wishlist item response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get wishlist item json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get wishlist item realData $realData");
        return WishListModel.fromJson(realData);
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

  Future<WishListAddRemoveModel?> addRemoveWishListItem(
      {required String productId, required String wishStatus}) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "product_id": productId,
      "wishlist_status": wishStatus
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.addRemoveWish,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response add remove wishlist item response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response add remove wishlist item json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response add remove wishlist item realData $realData");
        return WishListAddRemoveModel.fromJson(realData);
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
