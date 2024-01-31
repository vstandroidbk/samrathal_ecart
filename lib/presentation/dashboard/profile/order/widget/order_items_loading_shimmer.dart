import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../logic/services/formatter.dart';

class OrderItemLoadingShimmer extends StatelessWidget {
  const OrderItemLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                color: Colors.grey,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            8.pw,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          color: Colors.grey,
                                          child: Text(
                                            "Product name",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              color: Colors.grey,
                                              child: Text(
                                                "5 * 2 kg",
                                                style: AppTextStyles.bodyBlack14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .textLight),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.ph,
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.grey,
                                          child: Text(
                                            Formatter.formatPrice(1200),
                                            textAlign: TextAlign.end,
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              // total amount
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppColors.profileLabelBg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "Total",
                              style: AppTextStyles.bodyBlack16.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(12000),
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    5.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "Total",
                              style: AppTextStyles.bodyBlack16.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(12000),
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              12.ph,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppColors.profileLabelBg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "Total",
                              style: AppTextStyles.bodyBlack16.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(12000),
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    5.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "Total",
                              style: AppTextStyles.bodyBlack16.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(12000),
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    5.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "Total",
                              style: AppTextStyles.bodyBlack16.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(12000),
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
