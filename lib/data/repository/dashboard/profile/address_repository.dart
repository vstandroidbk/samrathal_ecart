import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/address_list_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/city_model.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/address/state_model.dart';
import 'package:samrathal_ecart/logic/services/preferences.dart';

import '../../../../core/api.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../logic/services/DataEncryption.dart';
import '../../../../utils/utils.dart';
import '../../../model/dashboard/profile/address/edit_address_data_model.dart';

class AddressRepository {
  final Api _api = Api();

  Future<StateModel?> getState() async {
    var jsonBody = {"state": ""};
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.getState,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get state response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get state json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get state realData $realData");
        return StateModel.fromJson(realData);
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
      return null;
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<CityModel?> getCity({required String stateId}) async {
    var jsonBody = {"stateId": stateId};
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.getCity,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get city response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get city json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get city realData $realData");
        return CityModel.fromJson(realData);
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
      return null;
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<bool?> addAddress({
    required String stateId,
    required String cityId,
    required String address,
    required String zipCode,
    required String landMark,
    required String primaryStatus,
  }) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    final mobile =
        await SharedPrefProvider.getString(SharedPrefProvider.mobile);
    var jsonBody = {
      "mobileNumber": mobile,
      "user_id": userId,
      "stateId": stateId,
      "districtId": cityId,
      "address": address,
      "zip_code": zipCode,
      "landmark": landMark,
      "primary_status": primaryStatus
    };
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.addAddress,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response add address response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response add address json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response add address realData $realData");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
      return false;
    } catch (ex) {
      rethrow;
    }
  }

  Future<AddressListModel?> getAddressList() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getAddressList,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get address list response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get address list json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get address list realData $realData");
        return AddressListModel.fromJson(realData);
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
      return null;
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<EditAddressDataModel?> getEditAddressData(String addressId) async {
    var jsonBody = {"addressId": addressId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getEditAddressData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get edit address data response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get edit address data json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get edit address data realData $realData");
        return EditAddressDataModel.fromJson(realData);
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
      return null;
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<bool?> updateAddress({
    required String stateId,
    required String cityId,
    required String addressId,
    required String address,
    required String zipCode,
    required String landMark,
    required String primaryStatus,
  }) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "user_id": userId,
      "addressId": addressId,
      "stateId": stateId,
      "districtId": cityId,
      "address": address,
      "zip_code": zipCode,
      "landmark": landMark,
      "primary_status": primaryStatus
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.updateAddress,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response update address response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response update address json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response update address realData $realData");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
      return false;
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool?> updatePrimaryStatus({
    required String addressId,
  }) async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {
      "addressId": addressId,
      "user_id": userId,
    };
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.updatePrimaryAddress,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response update primary status response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response update primary status json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response update primary status realData $realData");
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
      // if (e.response != null) {
      //   throw e.response!.data["message"];
      //   // log("exception error data ${e.response!.data}");
      //   // log("exception error headers ${e.response!.headers}");
      //   // log("exception error request options ${e.response!.requestOptions}");
      // }
      return false;
    } catch (ex) {
      rethrow;
    }
  }
}
