import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_const.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.options.headers = ApiEndPoints.headerContent;
    _dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true));
  }

  Dio get sendRequest => _dio;

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

class ApiResponse {
  String? status;
  String? message;
  List<Data>? data;

  ApiResponse({this.status, this.message, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? resData;
  String? resKey;

  Data({this.resData, this.resKey});

  Data.fromJson(Map<String, dynamic> json) {
    resData = json['resData'];
    resKey = json['resKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resData'] = resData;
    data['resKey'] = resKey;
    return data;
  }
}
