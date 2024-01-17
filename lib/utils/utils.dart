import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrathal_ecart/core/app_colors.dart';

import '../data/model/dashboard/profile/address/city_model.dart';
import '../data/model/dashboard/profile/address/state_model.dart';

double kHeight = 0;
double kWidth = 0;

extension PaddingHeight on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );

  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

removeFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

class Utils {
  static showToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }

  static showErrorMsg(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Color getStatusColor(String status) {
  if (status == "Pending") {
    return AppColors.pendingStatusColor;
  }
  if (status == "Canceled") {
    return AppColors.canceledStatusColor;
  }
  if (status == "Delivered") {
    return AppColors.deliveredStatusColor;
  }
  if (status == "Shipped") {
    return AppColors.shippedStatusColor;
  }
  if (status == "Processing") {
    return AppColors.processingStatusColor;
  }
  return Colors.black;
}

String? findStateIdByName(List<StateData>? stateData, String stateName) {
  try {
    StateData? state =
        stateData?.firstWhere((element) => element.stateName == stateName);
    return state?.id;
  } catch (e) {
    return null;
  }
}

String? findCityIdByName(List<DistrictData>? stateData, String stateName) {
  try {
    DistrictData? state =
        stateData?.firstWhere((element) => element.districtName == stateName);
    return state?.id;
  } catch (e) {
    return null;
  }
}

List<List<int>> getSplitList(String inputStr) {
  String inputString = '1-5-1,2-10-2,3-25-1,4-268-2';
  var splitVal = inputString.split(",");
  log("split comma val$splitVal");
  List<List<int>> resultList = [];

  for (String pair in splitVal) {
    List<int> values =
        pair.split('-').map((value) => int.parse(value)).toList();
    resultList.add(values);
  }
  log("final list $resultList");
  return resultList;
}

String getKgVal(List<int> size) {
  if (size[0] == 1) {
    return "5 Kg";
  } else if (size[0] == 2) {
    return "10 Kg";
  } else if (size[0] == 3) {
    return "25 Kg";
  } else if (size[0] == 4) {
    return "Random";
  }
  return "";
}

String getPcsFromTonKg(List<int> size) {
  if (size[2] == 1) {
    var qty = size[1] * 1000;
    if (size[0] == 1) {
      var fiveQty = qty / 5;
      return "${fiveQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 2) {
      var tenQty = qty / 10;
      return "${tenQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 3) {
      var twentyFiveQty = qty / 25;
      return "${twentyFiveQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 4) {
      return "${size[1]} Ton";
    }
  } else {
    var qty = size[1];
    if (size[0] == 1) {
      var fiveQty = qty / 5;
      return "${fiveQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 2) {
      var tenQty = qty / 10;
      return "${tenQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 3) {
      var twentyFiveQty = qty / 25;
      return "${twentyFiveQty.toStringAsFixed(0)} pc";
    } else if (size[0] == 4) {
      return "${size[1]} Kg";
    }
  }
  return "";
}
