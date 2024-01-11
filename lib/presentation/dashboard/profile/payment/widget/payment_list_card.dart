import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/logic/services/formatter.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../../widgets/custom_button.dart';
import '../payment_details_screen.dart';

class PaymentListCard extends StatelessWidget {
  final int index;

  const PaymentListCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var paymentData = paymentList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.orderIdTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(":"),
                  Expanded(
                    child: Text(
                      paymentData["orderId"]!,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentIdTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(":"),
                  Expanded(
                    child: Text(
                      paymentData["paymentId"]!,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentDateTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(":"),
                  Expanded(
                    child: Text(
                      paymentData["paymentDate"]!,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentStatusTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Text(":"),
                  Expanded(
                    child: Text(
                      paymentData["status"]!,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(color: AppColors.pendingStatusColor),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    AppStrings.paymentAmtTxt,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
                  const Text(":"),
                  Expanded(
                      child: Text(
                    Formatter.formatPrice(
                      int.parse(paymentData["amount"]!),
                    ),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
                ],
              ),
              5.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: 100,
                    height: 35,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentDetailsScreen(),
                        ),
                      );
                    },
                    isGradient: false,
                    backgroundColor: AppColors.greenBtnColor,
                    child: Text(
                      AppStrings.payNowTxt.toUpperCase(),
                      style: AppTextStyles.bodyWhite12,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.eye_solid,
                    color: AppColors.lightGrey,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
