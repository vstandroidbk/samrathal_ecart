import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../widgets/custom_button.dart';

class OrderPaymentListShimmer extends StatelessWidget {
  const OrderPaymentListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            AppStrings.orderIdTxt,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "12346788",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            AppStrings.orderIdTxt,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "12346788",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            AppStrings.orderIdTxt,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "12346788",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            AppStrings.orderIdTxt,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "12346788",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            AppStrings.orderIdTxt,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "12346788",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        width: 100,
                        height: 35,
                        onPressed: () {},
                        isGradient: false,
                        backgroundColor: AppColors.greenBtnColor,
                        child: Text(
                          AppStrings.payNowTxt.toUpperCase(),
                          style: AppTextStyles.bodyWhite12,
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        child: const Icon(
                          CupertinoIcons.eye_solid,
                          color: AppColors.lightGrey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
