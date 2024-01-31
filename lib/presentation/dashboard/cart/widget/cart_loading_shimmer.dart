import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/services/formatter.dart';
import '../../../../widgets/custom_button.dart';

class CartLoadingShimmer extends StatelessWidget {
  const CartLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.ph,
            Container(
              color: Colors.grey,
              child: Text(
                AppStrings.cartItemsTxt,
                style: AppTextStyles.bodyBlack14
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            ListView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                            height: 50,
                            color: Colors.grey,
                            width: 50,
                          ),
                        ),
                        12.pw,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      child: Text(
                                        "Product Name",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.bodyBlack14
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    3.ph,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: Colors.grey,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Remove",
                                                style: AppTextStyles.bodyBlack12
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        8.pw,
                                        Expanded(
                                          child: Container(
                                            color: Colors.grey,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                "Edit",
                                                style: AppTextStyles.bodyBlack12
                                                    .copyWith(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              8.pw,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "5 Kg",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textLight),
                                          ),
                                          Text(
                                            " * ",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.textLight),
                                          ),
                                          Text(
                                            "10 pc",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textLight),
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.ph,
                                    Container(
                                      color: Colors.grey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "10 kg",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textLight),
                                          ),
                                          Text(
                                            " * ",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textLight),
                                          ),
                                          Text(
                                            "20 pc",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.textLight),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.pw
                      ],
                    ),
                  ),
                );
              },
            ),
            5.ph,
            // total amount
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: const BoxDecoration(
                color: AppColors.profileLabelBg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Total",
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        8.pw,
                        Text(
                          Formatter.formatPrice(12000),
                          style: AppTextStyles.bodyBlack14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  5.ph,
                  Container(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Shipping Charge",
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        8.pw,
                        Text(
                          Formatter.formatPrice(500),
                          style: AppTextStyles.bodyBlack14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  5.ph,
                  Container(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Grand Total",
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        8.pw,
                        Text(
                          Formatter.formatPrice(11500),
                          style: AppTextStyles.bodyBlack14.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            12.ph,
            Container(
              color: Colors.grey,
              child: Text(
                "Estimate Distance 10 km",
                style: AppTextStyles.bodyBlack14,
              ),
            ),
            12.ph,
            // address
            Container(
              color: Colors.grey,
              child: Text(
                AppStrings.shipAddressTxt,
                style: AppTextStyles.bodyBlack14
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            5.ph,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.profileLabelBg,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "Deliver To:",
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      12.pw,
                      SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            side: const BorderSide(
                              width: 1.0,
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Text(
                            "Change",
                            style: AppTextStyles.bodyBlack14
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  8.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "A-1, Bombay,Queens road,  jhotwara Jaipur",
                            style: AppTextStyles.bodyBlack14,
                          ),
                        ),
                      ),
                      8.pw,
                      Container(
                        color: Colors.grey,
                        child: Image.asset(
                          AppImages.locationImg,
                          height: 40,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            12.ph,
            // receive now and pay now buttons
            CustomButton(
              height: 40,
              onPressed: () {},
              isGradient: false,
              backgroundColor: AppColors.redBtnColor,
              child: Text(
                AppStrings.checkoutTxt.toUpperCase(),
                style: AppTextStyles.bodyWhite14,
              ),
            ),
            16.ph,
          ],
        ),
      ),
    );
  }
}
