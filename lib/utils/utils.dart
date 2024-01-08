import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrathal_ecart/core/app_colors.dart';

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
