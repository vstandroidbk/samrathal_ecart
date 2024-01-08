import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/logic/services/formatter.dart';
import 'package:samrathal_ecart/presentation/dashboard/shop/widget/product_slider_widget.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';
import 'package:samrathal_ecart/widgets/custom_paragraph.dart';
import 'package:samrathal_ecart/widgets/label_widget.dart';

import '../../../widgets/custom_text_field.dart';
import '../dashboard_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String routeName = "Product Details Screen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<SizeInfo> sizes = [
    SizeInfo(id: 1, size: '5 kg'),
    SizeInfo(id: 2, size: '10 kg'),
    SizeInfo(id: 3, size: '25 kg'),
    SizeInfo(id: 5, size: 'Random'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.productDetailsTxt),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardScreen.routeName,
                  arguments: 2,
                  (route) => false);
            },
            child: Badge(
              label: Text(
                "12",
                style: AppTextStyles.bodyBlack12,
              ),
              backgroundColor: Colors.white,
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ),
          ),
          16.pw,
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // const ProductSliderWidget(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                // width: size.width,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.productImg1,
                      width: double.infinity,
                      height: 150,
                      // imageUrl: i,
                      /*Network.baseUrl + widget.sliderImgPath + i.image!,*/
                      fit: BoxFit.fill,
                      // placeholder: (context, url) => const SizedBox(),
                      // errorWidget: (context, url, error) =>
                      //     const Icon(Icons.error),
                    ),
                  ),
                )),
          ),
          12.ph,
          // product name and sku
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "18 SWG Mild Steel Binding Wire",
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  3.ph,
                  Text(
                    "wssxd-wuih",
                    style: AppTextStyles.bodyBlack14
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  3.ph,
                  Text(
                    "Price : ${Formatter.formatPrice(5000)}",
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              )),
              const Icon(CupertinoIcons.heart)
            ],
          ),
          // packaging size
          12.ph,
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.packingSizeTxt,
                  style: AppTextStyles.bodyBlack14
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Text(
                  "MOQ:1ton",
                  textAlign: TextAlign.right,
                  style: AppTextStyles.bodyBlack14
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          8.ph,
          Wrap(
            spacing: 16.0,
            runSpacing: 8.0,
            children: sizes
                .map((size) => Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1)),
                      child: Text(
                        size.size,
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ))
                .toList(),
          ),
          12.ph,
          Text(
            AppStrings.descriptionTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w600),
          ),
          5.ph,
          CustomParagraph(description: AppStrings.introDescTxt),
          12.ph,
          Text(
            AppStrings.productDetailsTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w600),
          ),
          5.ph,
          const ProductDetailsLabel(
            title: "Application Area",
            value: " For Construction",
          ),
          3.ph,
          const ProductDetailsLabel(
            title: "Wire Material",
            value: "Mild Steel",
          ),
          3.ph,
          const ProductDetailsLabel(
            title: "Conductor Type",
            value: "Solid",
          ),
          3.ph,
          const ProductDetailsLabel(
            title: "Uses/Application",
            value: "For Agriculture",
          ),
          20.ph,
          CustomButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return const ProductDetailSDialog();
                },
              );
            },
            isGradient: false,
            child: Text(
              AppStrings.addToCartTxt.toUpperCase(),
              style: AppTextStyles.bodyWhite14,
            ),
          )
        ],
      ),
    );
  }
}

class ProductDetailSDialog extends StatefulWidget {
  const ProductDetailSDialog({super.key});

  @override
  State<ProductDetailSDialog> createState() => _ProductDetailSDialogState();
}

class _ProductDetailSDialogState extends State<ProductDetailSDialog> {
  ValueNotifier<int?> selectedValue = ValueNotifier<int?>(null);
  TextEditingController qtyController = TextEditingController();
  String? dropdownValueFive = "0";
  String? dropdownValueTen = "0";
  String? dropdownValueTwenty = "0";
  String? dropdownValueRandom = "0";

  List<Map<String, dynamic>> dropDownWeightList = [
    {"id": "0", "status": "Ton"},
    {"id": "1", "status": "KG"},
  ];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textFieldController5 = TextEditingController();
  final TextEditingController _textFieldController10 = TextEditingController();
  final TextEditingController _textFieldController25 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: 278,
      // width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Form(
            // key: _formKey,
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
                          _textFieldController5,
                          5,
                        ),
                      ),
                    ),
                    // 8.pw,
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.textFieldBgColor),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: dropdownValueFive,
                              isExpanded: true,
                              isDense: true,
                              style: AppTextStyles.bodyBlack14,
                              onChanged: (onChangedValue) async {
                                setState(() {
                                  dropdownValueFive = onChangedValue!;
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return dropDownWeightList.map((value) {
                                  return Center(
                                    child: Text(
                                      value["status"],
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  );
                                }).toList();
                              },
                              items: dropDownWeightList.map(
                                (item) {
                                  return DropdownMenuItem(
                                    value: item["id"].toString(),
                                    child: Text(
                                      item["status"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                          _textFieldController10,
                          10,
                        ),
                      ),
                    ),
                    // 8.pw,
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.textFieldBgColor),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: dropdownValueTen,
                              isExpanded: true,
                              isDense: true,
                              style: AppTextStyles.bodyBlack14,
                              onChanged: (onChangedValue) async {
                                setState(() {
                                  dropdownValueTen = onChangedValue!;
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return dropDownWeightList.map((value) {
                                  return Center(
                                    child: Text(
                                      value["status"],
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  );
                                }).toList();
                              },
                              items: dropDownWeightList.map(
                                (item) {
                                  return DropdownMenuItem(
                                    value: item["id"].toString(),
                                    child: Text(
                                      item["status"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                8.ph,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "20 KG",
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
                          _textFieldController25,
                          25,
                        ),
                      ),
                    ),
                    // 8.pw,
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.textFieldBgColor),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: dropdownValueTwenty,
                              isExpanded: true,
                              isDense: true,
                              style: AppTextStyles.bodyBlack14,
                              onChanged: (onChangedValue) async {
                                setState(() {
                                  dropdownValueTwenty = onChangedValue!;
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return dropDownWeightList.map((value) {
                                  return Center(
                                    child: Text(
                                      value["status"],
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  );
                                }).toList();
                              },
                              items: dropDownWeightList.map(
                                (item) {
                                  return DropdownMenuItem(
                                    value: item["id"].toString(),
                                    child: Text(
                                      item["status"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                8.ph,
                Row(
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
                          textController: qtyController,
                          hintText: AppStrings.quantityTxt,
                          digitOnly: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    // 8.pw,
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.textFieldBgColor),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: dropdownValueRandom,
                              isExpanded: true,
                              isDense: true,
                              style: AppTextStyles.bodyBlack14,
                              onChanged: (onChangedValue) async {
                                setState(() {
                                  dropdownValueRandom = onChangedValue!;
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return dropDownWeightList.map((value) {
                                  return Center(
                                    child: Text(
                                      value["status"],
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  );
                                }).toList();
                              },
                              items: dropDownWeightList.map(
                                (item) {
                                  return DropdownMenuItem(
                                    value: item["id"].toString(),
                                    child: Text(
                                      item["status"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                        qtyController.text.trim().isEmpty
                            ? "N/A"
                            : qtyController.text,
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ),
                    5.pw,
                    Flexible(
                      child: Text(
                        selectedValue.value == null ||
                                qtyController.text.trim().isEmpty
                            ? " "
                            : selectedValue.value == 1
                                ? "Ton"
                                : "Kg",
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
                        qtyController.text.trim().isEmpty
                            ? "N/A"
                            : qtyController.text,
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ),
                    5.pw,
                    Flexible(
                      child: Text(
                        selectedValue.value == null ||
                                qtyController.text.trim().isEmpty
                            ? " "
                            : selectedValue.value == 1
                                ? "Ton"
                                : "Kg",
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ),
                  ],
                ),
                12.ph,
                Text(
                  "If you will add 50 kg more then you will get it at 5000/kg",
                  style: AppTextStyles.bodyBlack14
                      .copyWith(color: AppColors.primaryColor),
                ),
                20.ph,
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isGradient: false,
                  child: Text(
                    "Place order".toUpperCase(),
                    style: AppTextStyles.bodyWhite14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String hintText, TextEditingController controller, int multiple) {
    return CustomTextField(
      textController: controller,
      maxLine: 1,
      keyboardType: TextInputType.number,
      hintText: hintText,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter a value';
      //   }
      //   int? inputValue = int.tryParse(value);
      //   if (inputValue != null && inputValue % multiple == 0) {
      //     return null;
      //   }
      //   return 'Please enter a valid multiple of $multiple';
      // },
      onChanged: (value) {
        _formKey.currentState!.validate();
      },
    );
  }
}

class ProductDetailsLabel extends StatelessWidget {
  final String title;
  final String value;

  const ProductDetailsLabel(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyBlack14,
          ),
        ),
        const Text(":"),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class SizeInfo {
  final int id;
  final String size;

  SizeInfo({required this.id, required this.size});
}
