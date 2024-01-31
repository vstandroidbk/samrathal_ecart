import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/dashboard/shop/product_details_model.dart';
import '../../../../utils/app_utils.dart';
import '../../../services/formatter.dart';
import '../cart/cart_api_provider.dart';

class AddCartCalculatorProvider with ChangeNotifier {
  TextEditingController randomQtyController = TextEditingController();
  TextEditingController textFieldController5 = TextEditingController();
  TextEditingController textFieldController10 = TextEditingController();
  TextEditingController textFieldController25 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String dropdownValueFive = "1";
  String dropdownValueTen = "1";
  String dropdownValueTwentyFive = "1";
  String dropdownValueRandom = "1";

  List<Map<String, dynamic>> dropDownWeightList = [
    {"id": "1", "status": "Ton"},
    {"id": "2", "status": "KG"},
  ];
  String errorMessage5 = '';
  String errorMessage10 = '';
  String errorMessage25 = '';

  String? totalOrderPrice;
  String? totalOrderQty;
  String? addMoreMessage;

  void calculateAmountQty(ProductDetails productDetails) {
    var fiveKgInput = textFieldController5.text.trim();
    var tenKgInput = textFieldController10.text.trim();
    var twentyKgInput = textFieldController25.text.trim();
    var randomInput = randomQtyController.text.trim();
    num totalQty = 0;
    num totalPrice = 0;
    if (fiveKgInput.isNotEmpty) {
      if (dropdownValueFive == "1") {
        totalQty = totalQty += (num.parse(fiveKgInput) * 1000);
      } else {
        totalQty = totalQty += (num.parse(fiveKgInput));
      }
    }

    if (tenKgInput.trim().isNotEmpty) {
      if (dropdownValueTen == "1") {
        totalQty = totalQty += (num.parse(tenKgInput) * 1000);
      } else {
        totalQty = totalQty += (num.parse(tenKgInput));
      }
    }

    if (twentyKgInput.trim().isNotEmpty) {
      if (dropdownValueTwentyFive == "1") {
        totalQty = totalQty += (num.parse(twentyKgInput) * 1000);
      } else {
        totalQty = totalQty += (num.parse(twentyKgInput));
      }
    }

    if (randomInput.trim().isNotEmpty) {
      if (dropdownValueRandom == "1") {
        totalQty = totalQty += (num.parse(randomInput) * 1000);
      } else {
        totalQty = totalQty += (num.parse(randomInput));
      }
    }

    num retailPrice = num.parse(productDetails.retailTonAmount!);
    num minWholeSaleTon = productDetails.wholeSaleTonMinQty!;
    num wholePrice = num.parse(productDetails.wholeSaleTonAmount!);
    if (totalQty < 1000) {
      totalOrderQty = "$totalQty Kg";
      totalPrice = (retailPrice / 1000) * totalQty;
      totalOrderPrice = Formatter.formatPrice(totalPrice);
      var remainingQty = minWholeSaleTon * 1000 - totalQty;
      addMoreMessage =
          "If you will add ${remainingQty / 1000} Ton more then you will get it at $wholePrice/Ton";
    } else {
      num qtyInTon = totalQty / 1000;
      totalOrderQty = "$qtyInTon Ton";
      if (qtyInTon >= minWholeSaleTon) {
        totalPrice = wholePrice * qtyInTon;
        totalOrderPrice = Formatter.formatPrice(totalPrice);
        addMoreMessage = null;
      } else {
        totalPrice = retailPrice * qtyInTon;
        totalOrderPrice = Formatter.formatPrice(totalPrice);
        var remainingQty = minWholeSaleTon * 1000 - totalQty;
        addMoreMessage =
            "If you will add ${remainingQty / 1000} Ton more then you will get it at $wholePrice/Ton";
      }
    }
    /*if (productDetails.wholeSaleTonAmount != null &&
        productDetails.wholeSaleTonMinQty != null) {
      num minWholeSaleTon = productDetails.wholeSaleTonMinQty!;
      num wholePrice = num.parse(productDetails.wholeSaleTonAmount!);
      if (totalQty < 1000) {
        totalOrderQty = "$totalQty Kg";
      } else {
        totalOrderQty = "${totalQty / 1000} Ton";
      }
    } else {
      num retailPrice = num.parse(productDetails.retailTonAmount!);
      if (totalQty < 1000) {
        totalOrderQty = "$totalQty Kg";
      } else {
        totalOrderQty = "${totalQty / 1000} Ton";
      }
    }*/
    notifyListeners();
  }

  Future<void> validateInputFields(
      {required BuildContext buildContext,
      required BuildContext context,
      required String productId}) async {
    if (textFieldController5.text.trim().isEmpty &&
        textFieldController10.text.trim().isEmpty &&
        textFieldController25.text.trim().isEmpty &&
        randomQtyController.text.trim().isEmpty) {
      Utils.showToast("Please enter quantity");
      return;
    }
    if (errorMessage5.isNotEmpty ||
        errorMessage10.isNotEmpty ||
        errorMessage25.isNotEmpty) {
      Utils.showToast("Please enter valid input");
      return;
    }
    List<AddCartData> addCartList = [];
    if (textFieldController5.text.trim().isNotEmpty) {
      addCartList.add(AddCartData(
          size: 1,
          qty: int.parse(textFieldController5.text),
          weight: int.parse(dropdownValueFive)));
    }

    if (textFieldController10.text.trim().isNotEmpty) {
      addCartList.add(AddCartData(
          size: 2,
          qty: int.parse(textFieldController10.text),
          weight: int.parse(dropdownValueTen)));
    }
    if (textFieldController25.text.trim().isNotEmpty) {
      addCartList.add(AddCartData(
          size: 3,
          qty: int.parse(textFieldController25.text),
          weight: int.parse(dropdownValueTwentyFive)));
    }
    if (randomQtyController.text.trim().isNotEmpty) {
      addCartList.add(AddCartData(
          size: 4,
          qty: int.parse(randomQtyController.text),
          weight: int.parse(dropdownValueRandom)));
    }
    log("selected cart data array: $addCartList");
    List<Map<String, dynamic>> cartListJson =
        addCartList.map((cartItem) => cartItem.toMap()).toList();
    log("selected cart data json list: $cartListJson");

    var addedToCart = await Provider.of<CartApiProvider>(context, listen: false)
        .addToCart(
            productId: productId, addCartData: cartListJson, context: context);
    if (context.mounted && addedToCart) {
      Navigator.pop(context);
    }
  }

  setDataNull() {
    randomQtyController.text = "";
    textFieldController5.text = "";
    textFieldController10.text = "";
    textFieldController25.text = "";
    dropdownValueFive = "1";
    dropdownValueTen = "1";
    dropdownValueTwentyFive = "1";
    dropdownValueRandom = "1";
    errorMessage5 = '';
    errorMessage10 = '';
    errorMessage25 = '';
    totalOrderPrice = null;
    totalOrderQty = null;
    addMoreMessage = null;
  }
}

class AddCartData {
  int size;
  int qty;
  int weight;

  AddCartData({required this.size, required this.qty, required this.weight});

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'qty': qty,
      'weight': weight,
    };
  }
}
