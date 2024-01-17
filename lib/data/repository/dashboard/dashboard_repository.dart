import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/api.dart';
import '../../../core/api_const.dart';
import '../../../core/app_strings.dart';
import '../../../logic/services/DataEncryption.dart';
import '../../../logic/services/preferences.dart';
import '../../model/dashboard/dashboard_data_model.dart';
import '../../model/dashboard/profile/profile_data_model.dart';

class DashboardRepository {
  final Api _api = Api();

  Future<ProfileDataModel?> getProfileData() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getProfileData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get profile data response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get profile data json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get profile data realData $realData");
        return ProfileDataModel.fromJson(realData);
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

  Future<DashboardDataModel?> getDashboardData() async {
    final userId =
        await SharedPrefProvider.getString(SharedPrefProvider.userId);
    var jsonBody = {"user_id": userId};
    try {
      Response response = await _api.sendRequest.post(
          ApiEndPoints.getDashboardData,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response get dashboard data response ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response get dashboard data json ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      // Utils.showToast(apiResponse.message.toString());
      if (apiResponse.data != null) {
        var realData = DataEncryption.getDecryptedData(
            apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
        log("api response get dashboard data realData $realData");
        return DashboardDataModel.fromJson(realData);
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
