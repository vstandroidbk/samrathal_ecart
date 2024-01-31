import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/shop/product_details_model.dart';
import '../../../../logic/provider/dashboard/cart/cart_api_provider.dart';
import '../../../../logic/provider/dashboard/shop/add_cart_calculator_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/loader_widget.dart';

class AddToCartDialog extends StatefulWidget {
  final ProductDetails productDetails;
  final BuildContext buildContext;

  const AddToCartDialog(
      {super.key, required this.productDetails, required this.buildContext});

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
/*
  TextEditingController randomQtyController = TextEditingController();
  TextEditingController textFieldController5 = TextEditingController();
  TextEditingController textFieldController10 = TextEditingController();
  TextEditingController textFieldController25 = TextEditingController();

  String? dropdownValueFive = "0";
  String? dropdownValueTen = "0";
  String? dropdownValueTwenty = "0";
  String? dropdownValueRandom = "0";

  List<Map<String, dynamic>> dropDownWeightList = [
    {"id": "0", "status": "Ton"},
    {"id": "1", "status": "KG"},
  ];

  final _formKey = GlobalKey<FormState>();
  String _errorMessage5 = '';
  String _errorMessage10 = '';
  String _errorMessage25 = '';
*/

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
          child: Consumer<AddCartCalculatorProvider>(
            builder: (BuildContext context,
                AddCartCalculatorProvider amtCalProvider, Widget? child) {
              return Column(
                children: [
                  Form(
                    key: amtCalProvider.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Size",
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.bodyBlack16
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              5.pw,
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "QTY",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyBlack16
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              8.pw,
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Weight",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodyBlack16
                                      .copyWith(fontWeight: FontWeight.w600),
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
                                      amtCalProvider.textFieldController5,
                                      5,
                                      validateInput5,
                                      amtCalProvider),
                                ),
                              ),
                              // 8.pw,
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: AppColors.textFieldBgColor),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        value: amtCalProvider.dropdownValueFive,
                                        isExpanded: true,
                                        isDense: true,
                                        style: AppTextStyles.bodyBlack14,
                                        onChanged: (onChangedValue) async {
                                          setState(() {
                                            amtCalProvider.dropdownValueFive =
                                                onChangedValue!;
                                            amtCalProvider.calculateAmountQty(
                                                widget.productDetails);
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
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        items: amtCalProvider.dropDownWeightList
                                            .map(
                                          (item) {
                                            return DropdownMenuItem(
                                              value: item["id"].toString(),
                                              child: Text(
                                                item["status"].toString(),
                                                style:
                                                    AppTextStyles.bodyBlack14,
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
                                    style: AppTextStyles.bodyBlack12.copyWith(
                                        color: AppColors.primaryColor),
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
                                      amtCalProvider.textFieldController10,
                                      10,
                                      validateInput10,
                                      amtCalProvider),
                                ),
                              ),
                              // 8.pw,
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: AppColors.textFieldBgColor),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        value: amtCalProvider.dropdownValueTen,
                                        isExpanded: true,
                                        isDense: true,
                                        style: AppTextStyles.bodyBlack14,
                                        onChanged: (onChangedValue) async {
                                          setState(() {
                                            amtCalProvider.dropdownValueTen =
                                                onChangedValue!;
                                            amtCalProvider.calculateAmountQty(
                                                widget.productDetails);
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
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        items: amtCalProvider.dropDownWeightList
                                            .map(
                                          (item) {
                                            return DropdownMenuItem(
                                              value: item["id"].toString(),
                                              child: Text(
                                                item["status"].toString(),
                                                style:
                                                    AppTextStyles.bodyBlack14,
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
                          if (amtCalProvider.errorMessage10.isNotEmpty)
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
                                    style: AppTextStyles.bodyBlack12.copyWith(
                                        color: AppColors.primaryColor),
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
                                      amtCalProvider.textFieldController25,
                                      25,
                                      validateInput25,
                                      amtCalProvider),
                                ),
                              ),
                              // 8.pw,
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: const BoxDecoration(
                                      color: AppColors.textFieldBgColor),
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        value: amtCalProvider
                                            .dropdownValueTwentyFive,
                                        isExpanded: true,
                                        isDense: true,
                                        style: AppTextStyles.bodyBlack14,
                                        onChanged: (onChangedValue) async {
                                          setState(() {
                                            amtCalProvider
                                                    .dropdownValueTwentyFive =
                                                onChangedValue!;
                                            amtCalProvider.calculateAmountQty(
                                                widget.productDetails);
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
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        items: amtCalProvider.dropDownWeightList
                                            .map(
                                          (item) {
                                            return DropdownMenuItem(
                                              value: item["id"].toString(),
                                              child: Text(
                                                item["status"].toString(),
                                                style:
                                                    AppTextStyles.bodyBlack14,
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
                          if (amtCalProvider.errorMessage25.isNotEmpty)
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
                                    style: AppTextStyles.bodyBlack12.copyWith(
                                        color: AppColors.primaryColor),
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
                                      textController:
                                          amtCalProvider.randomQtyController,
                                      hintText: AppStrings.quantityTxt,
                                      digitOnly: true,
                                      // inputFormatter: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                                      // ],
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) {
                                        setState(() {});
                                        amtCalProvider.calculateAmountQty(
                                            widget.productDetails);
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
                                        color: AppColors.textFieldBgColor),
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          value: amtCalProvider
                                              .dropdownValueRandom,
                                          isExpanded: true,
                                          isDense: true,
                                          style: AppTextStyles.bodyBlack14,
                                          onChanged: (onChangedValue) async {
                                            setState(() {
                                              amtCalProvider
                                                      .dropdownValueRandom =
                                                  onChangedValue!;
                                              amtCalProvider.calculateAmountQty(
                                                  widget.productDetails);
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
                                                  style:
                                                      AppTextStyles.bodyBlack14,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          items: amtCalProvider
                                              .dropDownWeightList
                                              .map(
                                            (item) {
                                              return DropdownMenuItem(
                                                value: item["id"].toString(),
                                                child: Text(
                                                  item["status"].toString(),
                                                  style:
                                                      AppTextStyles.bodyBlack14,
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
                                  amtCalProvider.totalOrderPrice != null
                                      ? amtCalProvider.totalOrderPrice!
                                      : "N/A",
                                  style: AppTextStyles.bodyBlack14,
                                ),
                              ),
                            ],
                          ),
                          20.ph,
                          Consumer<CartApiProvider>(
                            builder: (BuildContext context,
                                CartApiProvider cartProvider, Widget? child) {
                              return cartProvider.addCartLoading
                                  ? const CustomButtonLoader()
                                  : CustomButton(
                                      onPressed: () {
                                        amtCalProvider.validateInputFields(
                                            buildContext: widget.buildContext,
                                            context: context,
                                            productId:
                                                widget.productDetails.id!);
                                      },
                                      isGradient: false,
                                      child: Text(
                                        "Add to Cart".toUpperCase(),
                                        style: AppTextStyles.bodyWhite14,
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // if (amtCalProvider.addMoreMessage != null) 12.ph,
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
      void Function(String, AddCartCalculatorProvider) validationFunction,
      AddCartCalculatorProvider amtCalProvider) {
    return CustomTextField(
      textController: controller,
      maxLine: 1,
      digitOnly: true,
      keyboardType: TextInputType.number,
      hintText: hintText,
      textInputAction: TextInputAction.done,
      onChanged: (input) {
        validationFunction(input, amtCalProvider);
        amtCalProvider.calculateAmountQty(widget.productDetails);
      },
    );
  }

  void validateInput5(String input, AddCartCalculatorProvider amtCalProvider) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage5 = '';
        return;
      }
      int? number = int.tryParse(input);
      if (number == null || number % 5 != 0) {
        amtCalProvider.errorMessage5 = 'Please enter a multiple of 5.';
      } else {
        amtCalProvider.errorMessage5 = '';
      }
    });
  }

  void validateInput10(String input, AddCartCalculatorProvider amtCalProvider) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage10 = '';
        return;
      }
      int? number = int.tryParse(input);
      if (number == null || number % 10 != 0) {
        amtCalProvider.errorMessage10 = 'Please enter a multiple of 10.';
      } else {
        amtCalProvider.errorMessage10 = '';
      }
    });
  }

  void validateInput25(String input, AddCartCalculatorProvider amtCalProvider) {
    setState(() {
      if (input.isEmpty) {
        amtCalProvider.errorMessage25 = '';
        return;
      }
      int? number = int.tryParse(input);
      if (number == null || number % 25 != 0) {
        amtCalProvider.errorMessage25 = 'Please enter a multiple of 25.';
      } else {
        amtCalProvider.errorMessage25 = '';
      }
    });
  }
}
