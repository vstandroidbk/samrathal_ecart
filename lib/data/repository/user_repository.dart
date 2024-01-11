import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/api.dart';
import '../../core/api_const.dart';
import '../../core/app_strings.dart';
import '../../logic/services/DataEncryption.dart';
import '../../utils/utils.dart';
import '../model/user/user_model.dart';

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class UserRepository {
  final Api _api = Api();

  Future<UserModel?> loginUser({
    required String mobile,
    required String password,
  }) async {
    var jsonBody = {"mobileNumber": mobile, "password": password};
    try {
      Response response = await _api.sendRequest.post(ApiEndPoints.loginUser,
          data: jsonEncode(DataEncryption.getEncryptedData(jsonBody)));
      log("api response login resp data ${jsonEncode(response.data)}");
      ApiResponse apiResponse =
          ApiResponse.fromJson(jsonDecode(jsonEncode(response.data)));
      log("api response login json data ${apiResponse.data}");
      if (apiResponse.status != AppStrings.successTxt) {
        throw apiResponse.message.toString();
      }
      var realData = DataEncryption.getDecryptedData(
          apiResponse.data![0].resKey!, apiResponse.data![0].resData!);
      log("api response login realData $realData");
      Utils.showToast(apiResponse.message.toString());
      return UserModel.fromJson(realData);
    } on SocketException catch (e) {
      throw NetworkException('Network Error: $e');
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            throw BadRequestException(e.response!.data["message"]);
          case 401:
            throw UnauthorizedException(e.response!.data["message"]);
          // Add more cases for handling other status codes as needed
          default:
            throw e.response!.data["message"];
        }
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
  }
}
