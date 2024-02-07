import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/cart/cart_item_list_model.dart';
import '../../../../logic/provider/dashboard/cart/cart_api_provider.dart';
import '../../../../logic/provider/dashboard/cart/update_cart_calculator_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/loader_widget.dart';

class UpdateCartDialog extends StatefulWidget {
  final CartData cartData;
  final BuildContext buildContext;

  const UpdateCartDialog(
      {super.key, required this.cartData, required this.buildContext});

  @override
  State<UpdateCartDialog> createState() => _UpdateCartDialogState();
}

class _UpdateCartDialogState extends State<UpdateCartDialog> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<CartApiProvider>(context, listen: false);
    dataProvider.setCartDetailsDataNull();
    var updateCartDataProvider =
        Provider.of<UpdateCartCalculatorProvider>(context, listen: false);
    await dataProvider.getCartItemDetailsApi(
        productId: widget.cartData.productId!);
    var cartDetailsModel = dataProvider.cartItemDetailsModel;
    if (cartDetailsModel != null && cartDetailsModel.itemData != null) {
      for (var itemData in cartDetailsModel.itemData!) {
        if (itemData.size == "1") {
          updateCartDataProvider.textFieldController5.text = itemData.quantity!;
          updateCartDataProvider.dropdownValueFive = itemData.weightType!;
        } else if (itemData.size == "2") {
          updateCartDataProvider.textFieldController10.text =
              itemData.quantity!;
          updateCartDataProvider.dropdownValueTen = itemData.weightType!;
        } else if (itemData.size == "3") {
          updateCartDataProvider.textFieldController25.text =
              itemData.quantity!;
          updateCartDataProvider.dropdownValueTwentyFive = itemData.weightType!;
        } else if (itemData.size == "4") {
          updateCartDataProvider.randomQtyController.text = itemData.quantity!;
          updateCartDataProvider.dropdownValueRandom = itemData.weightType!;
        }
      }
    }
    updateCartDataProvider.calculateAmountQty(widget.cartData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: 278,
      // width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Consumer<UpdateCartCalculatorProvider>(
            builder: (BuildContext context,
                UpdateCartCalculatorProvider amtCalProvider, Widget? child) {
              return Column(
                children: [
                  Form(
                    key: amtCalProvider.formKey,
                    child: Consumer<CartApiProvider>(
                      builder: (BuildContext context,
                          CartApiProvider cartProvider, Widget? child) {
                        return cartProvider.cartItemDetailsLoading
                            ? const SizedBox(
                                height: 300,
                                child: Center(
                                  child: SpinKitCircle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Size",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyles.bodyBlack16
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "QTY",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.bodyBlack16
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Weight",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.bodyBlack16
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    8.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "5 KG",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 40,
                                            child: buildTextFormField(
                                                'Enter multiple of 5',
                                                amtCalProvider
                                                    .textFieldController5,
                                                5,
                                                validateInput5,
                                                amtCalProvider,
                                                amtCalProvider
                                                    .dropdownValueFive),
                                          ),
                                        ),
                                        // 8.pw,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: const BoxDecoration(
                                                color:
                                                    AppColors.textFieldBgColor),
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButton<String>(
                                                  value: amtCalProvider
                                                      .dropdownValueFive,
                                                  isExpanded: true,
                                                  isDense: true,
                                                  style:
                                                      AppTextStyles.bodyBlack14,
                                                  onChanged:
                                                      (onChangedValue) async {
                                                    setState(() {
                                                      amtCalProvider
                                                              .dropdownValueFive =
                                                          onChangedValue!;
                                                      amtCalProvider
                                                          .calculateAmountQty(
                                                              widget.cartData);
                                                      validateInput5(
                                                          amtCalProvider
                                                              .textFieldController5
                                                              .text,
                                                          amtCalProvider,
                                                          amtCalProvider
                                                              .dropdownValueFive);
                                                    });
                                                  },
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return amtCalProvider
                                                        .dropDownWeightList
                                                        .map((value) {
                                                      return Center(
                                                        child: Text(
                                                          value["status"],
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  items: amtCalProvider
                                                      .dropDownWeightList
                                                      .map(
                                                    (item) {
                                                      return DropdownMenuItem(
                                                        value: item["id"]
                                                            .toString(),
                                                        child: Text(
                                                          item["status"]
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // error validation 5 kg--->>
                                    if (amtCalProvider.errorMessage5.isNotEmpty)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          5.pw,
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              amtCalProvider.errorMessage5,
                                              style: AppTextStyles.bodyBlack12
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor),
                                            ),
                                          ),
                                          // 8.pw,
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    8.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "10 KG",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 40,
                                            child: buildTextFormField(
                                                'Enter multiple of 10',
                                                amtCalProvider
                                                    .textFieldController10,
                                                10,
                                                validateInput10,
                                                amtCalProvider,
                                                amtCalProvider
                                                    .dropdownValueTen),
                                          ),
                                        ),
                                        // 8.pw,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: const BoxDecoration(
                                                color:
                                                    AppColors.textFieldBgColor),
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButton<String>(
                                                  value: amtCalProvider
                                                      .dropdownValueTen,
                                                  isExpanded: true,
                                                  isDense: true,
                                                  style:
                                                      AppTextStyles.bodyBlack14,
                                                  onChanged:
                                                      (onChangedValue) async {
                                                    setState(() {
                                                      amtCalProvider
                                                              .dropdownValueTen =
                                                          onChangedValue!;
                                                      amtCalProvider
                                                          .calculateAmountQty(
                                                              widget.cartData);
                                                      validateInput10(
                                                          amtCalProvider
                                                              .textFieldController10
                                                              .text,
                                                          amtCalProvider,
                                                          amtCalProvider
                                                              .dropdownValueTen);
                                                    });
                                                  },
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return amtCalProvider
                                                        .dropDownWeightList
                                                        .map((value) {
                                                      return Center(
                                                        child: Text(
                                                          value["status"],
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  items: amtCalProvider
                                                      .dropDownWeightList
                                                      .map(
                                                    (item) {
                                                      return DropdownMenuItem(
                                                        value: item["id"]
                                                            .toString(),
                                                        child: Text(
                                                          item["status"]
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // error validation 10 kg--->>
                                    if (amtCalProvider
                                        .errorMessage10.isNotEmpty)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          5.pw,
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              amtCalProvider.errorMessage10,
                                              style: AppTextStyles.bodyBlack12
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor),
                                            ),
                                          ),
                                          // 8.pw,
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    8.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "25 KG",
                                            textAlign: TextAlign.start,
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        5.pw,
                                        Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            height: 40,
                                            child: buildTextFormField(
                                                'Enter multiple of 25',
                                                amtCalProvider
                                                    .textFieldController25,
                                                25,
                                                validateInput25,
                                                amtCalProvider,
                                                amtCalProvider
                                                    .dropdownValueTwentyFive),
                                          ),
                                        ),
                                        // 8.pw,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: const BoxDecoration(
                                                color:
                                                    AppColors.textFieldBgColor),
                                            child: DropdownButtonHideUnderline(
                                              child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButton<String>(
                                                  value: amtCalProvider
                                                      .dropdownValueTwentyFive,
                                                  isExpanded: true,
                                                  isDense: true,
                                                  style:
                                                      AppTextStyles.bodyBlack14,
                                                  onChanged:
                                                      (onChangedValue) async {
                                                    setState(() {
                                                      amtCalProvider
                                                              .dropdownValueTwentyFive =
                                                          onChangedValue!;
                                                      amtCalProvider
                                                          .calculateAmountQty(
                                                              widget.cartData);
                                                      validateInput25(
                                                          amtCalProvider
                                                              .textFieldController25
                                                              .text,
                                                          amtCalProvider,
                                                          amtCalProvider
                                                              .dropdownValueTwentyFive);
                                                    });
                                                  },
                                                  selectedItemBuilder:
                                                      (BuildContext context) {
                                                    return amtCalProvider
                                                        .dropDownWeightList
                                                        .map((value) {
                                                      return Center(
                                                        child: Text(
                                                          value["status"],
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  items: amtCalProvider
                                                      .dropDownWeightList
                                                      .map(
                                                    (item) {
                                                      return DropdownMenuItem(
                                                        value: item["id"]
                                                            .toString(),
                                                        child: Text(
                                                          item["status"]
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .bodyBlack14,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // error validation 25 kg--->>
                                    if (amtCalProvider
                                        .errorMessage25.isNotEmpty)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          5.pw,
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              amtCalProvider.errorMessage25,
                                              style: AppTextStyles.bodyBlack12
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor),
                                            ),
                                          ),
                                          // 8.pw,
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    8.ph,
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Random",
                                              textAlign: TextAlign.start,
                                              style: AppTextStyles.bodyBlack14,
                                            ),
                                          ),
                                          5.pw,
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              height: 40,
                                              child: CustomTextField(
                                                textController: amtCalProvider
                                                    .randomQtyController,
                                                hintText:
                                                    AppStrings.quantityTxt,
                                                digitOnly: amtCalProvider
                                                            .dropdownValueRandom ==
                                                        "1"
                                                    ? false
                                                    : true,
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {});
                                                  amtCalProvider
                                                      .calculateAmountQty(
                                                          widget.cartData);
                                                },
                                              ),
                                            ),
                                          ),
                                          // 8.pw,
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 40,
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: const BoxDecoration(
                                                  color: AppColors
                                                      .textFieldBgColor),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: DropdownButton<String>(
                                                    value: amtCalProvider
                                                        .dropdownValueRandom,
                                                    isExpanded: true,
                                                    isDense: true,
                                                    style: AppTextStyles
                                                        .bodyBlack14,
                                                    onChanged:
                                                        (onChangedValue) async {
                                                      setState(() {
                                                        amtCalProvider
                                                                .dropdownValueRandom =
                                                            onChangedValue!;
                                                        amtCalProvider
                                                            .calculateAmountQty(
                                                                widget
                                                                    .cartData);
                                                      });
                                                    },
                                                    selectedItemBuilder:
                                                        (BuildContext context) {
                                                      return amtCalProvider
                                                          .dropDownWeightList
                                                          .map((value) {
                                                        return Center(
                                                          child: Text(
                                                            value["status"],
                                                            style: AppTextStyles
                                                                .bodyBlack14,
                                                          ),
                                                        );
                                                      }).toList();
                                                    },
                                                    items: amtCalProvider
                                                        .dropDownWeightList
                                                        .map(
                                                      (item) {
                                                        return DropdownMenuItem(
                                                          value: item["id"]
                                                              .toString(),
                                                          child: Text(
                                                            item["status"]
                                                                .toString(),
                                                            style: AppTextStyles
                                                                .bodyBlack14,
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    12.ph,
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Total Order Qty",
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        5.pw,
                                        const Text(":"),
                                        5.pw,
                                        Flexible(
                                          child: Text(
                                            amtCalProvider.totalOrderQty != null
                                                ? amtCalProvider.totalOrderQty!
                                                : "N/A",
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    8.ph,
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Total Price",
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        5.pw,
                                        const Text(":"),
                                        5.pw,
                                        Flexible(
                                          child: Text(
                                            amtCalProvider.totalOrderPrice !=
                                                    null
                                                ? amtCalProvider
                                                    .totalOrderPrice!
                                                : "N/A",
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // if (amtCalProvider.addMoreMessage != null)
                                    //   12.ph,
                                    // if (amtCalProvider.addMoreMessage != null)
                                    //   Text(
                                    //     amtCalProvider.addMoreMessage!,
                                    //     style: AppTextStyles.bodyBlack14
                                    //         .copyWith(
                                    //             color: AppColors.primaryColor),
                                    //   ),
                                    20.ph,
                                    Consumer<CartApiProvider>(
                                      builder: (BuildContext context,
                                          CartApiProvider cartProvider,
                                          Widget? child) {
                                        return cartProvider.updateCartLoading
                                            ? const CustomButtonLoader()
                                            : CustomButton(
                                                onPressed: () {
                                                  removeFocus(context);
                                                  amtCalProvider
                                                      .validateInputFields(
                                                          buildContext: widget
                                                              .buildContext,
                                                          context: context,
                                                          productId: widget
                                                              .cartData
                                                              .productId!);
                                                },
                                                isGradient: false,
                                                child: Text(
                                                  "Update Cart".toUpperCase(),
                                                  style:
                                                      AppTextStyles.bodyWhite14,
                                                ),
                                              );
                                      },
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  if (amtCalProvider.addMoreMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8),
                      decoration: const BoxDecoration(
                          color: CupertinoColors.systemGreen),
                      child: Text(
                        amtCalProvider.addMoreMessage!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyBlack12.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String hintText,
      TextEditingController controller,
      int multiple,
      void Function(String, UpdateCartCalculatorProvider, String unit)
          validationFunction,
      UpdateCartCalculatorProvider amtCalProvider,
      String unit) {
    return CustomTextField(
      textController: controller,
      maxLine: 1,
      // digitOnly: true,
      keyboardType: TextInputType.number,
      hintText: hintText,
      textInputAction: TextInputAction.done,
      onChanged: (input) {
        validationFunction(input, amtCalProvider, unit);
        amtCalProvider.calculateAmountQty(widget.cartData);
      },
    );
  }

  void validateInput5(
      String input, UpdateCartCalculatorProvider amtCalProvider, String unit) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage5 = '';
        return;
      }
      num? number = 0;
      if (unit == "1") {
        number = num.tryParse(input)! * 1000;
      } else {
        number = num.tryParse(input);
      }
      if (number == null || number % 5 != 0) {
        amtCalProvider.errorMessage5 = 'Please enter a multiple of 5.';
      } else {
        amtCalProvider.errorMessage5 = '';
      }
    });
  }

  void validateInput10(
      String input, UpdateCartCalculatorProvider amtCalProvider, String unit) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage10 = '';
        return;
      }
      num? number = 0;
      if (unit == "1") {
        number = num.tryParse(input)! * 1000;
      } else {
        number = num.tryParse(input);
      }
      if (number == null || number % 10 != 0) {
        amtCalProvider.errorMessage10 = 'Please enter a multiple of 10.';
      } else {
        amtCalProvider.errorMessage10 = '';
      }
    });
  }

  void validateInput25(
      String input, UpdateCartCalculatorProvider amtCalProvider, String unit) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage25 = '';
        return;
      }
      num? number = 0;
      if (unit == "1") {
        number = num.tryParse(input)! * 1000;
      } else {
        number = num.tryParse(input);
      }
      if (number == null || number % 25 != 0) {
        amtCalProvider.errorMessage25 = 'Please enter a multiple of 25.';
      } else {
        amtCalProvider.errorMessage25 = '';
      }
    });
  }
}
