import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/model/dashboard/cart/cart_item_list_model.dart';
import '../data/model/dashboard/profile/address/city_model.dart';
import '../data/model/dashboard/profile/address/state_model.dart';
import '../data/model/dashboard/profile/order_item_details_model.dart';
import '../data/model/dashboard/profile/order_payment_list_model.dart';

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

// 1:Placed
// 2:Approved
// 3:Shipped
// 4:Delivered
// 5:Received
// 6:Completed

String getStatus(int status) {
  switch (status) {
    case 1:
      return "Order Placed";
    case 2:
      return "Order Approved";
    case 3:
      return "Order Shipped";
    case 4:
      return "Order Delivered";
    case 5:
      return "Order Received";
    case 6:
      return "Order Completed";
    default:
      return "";
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case 1:
      return Colors.red;
    case 2:
      return Colors.deepOrange;
    case 3:
      return Colors.amber;
    case 4:
      return Colors.blue;
    case 5:
      return Colors.indigo;
    case 6:
      return Colors.green;
    default:
      return Colors.black;
  }
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

List<List<int>> getSplitList(String inputString) {
  // String inputString = '1-5-1,2-10-2,3-25-1,4-268-2';
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

num getCartTotalAmount(List<CartData> cartData) {
  num cartTotalAmount = 0;
  for (var cartData in cartData) {
    var splitList = getSplitList(cartData.itemData!);
    var getTotal = getTotalAmount(splitList, cartData.productData!);
    cartTotalAmount += getTotal;
  }
  if (kDebugMode) {
    print("total price all cart $cartTotalAmount");
  }
  return cartTotalAmount;
}

num getTotalAmount(List<List<int>> resultList, ProductData productData) {
  var retailPrice = num.parse(productData.retailTonAmount!);
  var wholePrice = num.parse(productData.wholeSaleTonAmount!);
  var minWholeSaleTon = productData.wholeSaleTonMinQty!;
  num totalQty = 0;
  num totalPrice = 0;
  for (var size in resultList) {
    if (size[2] == 1) {
      totalQty = totalQty += (size[1] * 1000);
    } else {
      totalQty = totalQty += size[1];
    }
  }
  num qtyInTon = totalQty / 1000;
  if (qtyInTon >= minWholeSaleTon) {
    totalPrice = wholePrice * qtyInTon;
  } else {
    totalPrice = retailPrice * qtyInTon;
  }
  if (kDebugMode) {
    print("total quantity ${totalQty / 1000}");
  }
  if (kDebugMode) {
    print("total price ${totalQty / 1000}");
  }
  return totalPrice;
}

num getTotalItemAmount(List<List<int>> resultList, OrderItemData productData) {
  var retailPrice = num.parse(productData.retailTonAmount!);
  var wholePrice = num.parse(productData.wholeSaleTonAmount!);
  var minWholeSaleTon = num.parse(productData.wholeSaleTonMinQty!);
  num totalQty = 0;
  num totalPrice = 0;
  for (var size in resultList) {
    if (size[2] == 1) {
      totalQty = totalQty += (size[1] * 1000);
    } else {
      totalQty = totalQty += size[1];
    }
  }
  num qtyInTon = totalQty / 1000;
  if (qtyInTon >= minWholeSaleTon) {
    totalPrice = wholePrice * qtyInTon;
  } else {
    totalPrice = retailPrice * qtyInTon;
  }
  if (kDebugMode) {
    print("total quantity ${totalQty / 1000}");
  }
  if (kDebugMode) {
    print("total price ${totalQty / 1000}");
  }
  return totalPrice;
}

String getPaymentTypeText(int paymentType, PaymentList paymentList) {
  if (paymentType == 1) {
    return "${paymentList.bankName} ( ${paymentList.accountNumber})";
  }
  if (paymentType == 2) {
    return "${paymentList.upiId}";
  }
  if (paymentType == 3) {
    return "Payment Via QR";
  }
  return "";
}
// num getGrandTotalAmt(List<List<int>> resultList, num shippingCharge) {
//   var grandTotal = getTotalAmount(resultList) + shippingCharge;
//   return grandTotal;
// }
