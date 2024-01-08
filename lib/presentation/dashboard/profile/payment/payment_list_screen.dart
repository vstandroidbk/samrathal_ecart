import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_details_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/payment_list_card.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  static const String routeName = "Payment List Screen";

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  String dropdownValue = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // backgroundColor: Colors.white,
        title: Text(AppStrings.paymentListTxt),
        actions: [
          Container(
            height: 35,
            width: 110,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  isDense: true,
                  style: AppTextStyles.bodyBlack14,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Image.asset(
                      AppImages.filterImg,
                      height: 18,
                      width: 18,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (onChangedValue) async {
                    setState(() {
                      dropdownValue = onChangedValue!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return paymentStatusList.map((value) {
                      return Center(
                        child: Text(
                          value["status"],
                          style: AppTextStyles.bodyWhite14,
                        ),
                      );
                    }).toList();
                  },
                  items: paymentStatusList.map(
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
          12.pw
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemCount: paymentList.length,
        itemBuilder: (ctx, index) {
          return PaymentListCard(index: index);
        },
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, PaymentDetailsScreen.routeName);
          },
          isGradient: false,
          backgroundColor: AppColors.greenBtnColor,
          child: Text(
            AppStrings.payNowTxt.toUpperCase(),
            style: AppTextStyles.bodyWhite14,
          ),
        ),
      ),*/
    );
  }
}
