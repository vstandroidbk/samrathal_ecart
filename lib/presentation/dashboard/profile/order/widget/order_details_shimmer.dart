import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_images.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../logic/services/formatter.dart';
import '../../../../../widgets/custom_button.dart';

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // order status
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors
                                .transparent, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color:
                                Colors.black, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color:
                                Colors.black, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color:
                                Colors.black, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color:
                                Colors.black, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 3,
                            color:
                                Colors.black, // Customize the color as needed
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    8.pw,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Order Placed",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    child: Text(
                                      'We have receive your order',
                                      style: AppTextStyles.bodyBlack14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.grey,
                              child: Text(
                                "31 Dec 2023",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              12.ph,
              // total items
              Container(
                color: Colors.grey,
                child: Text(
                  AppStrings.orderItemTxt,
                  style: AppTextStyles.bodyBlack14
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              5.ph,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
                              "5 Items",
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ),
                        ),
                        8.pw,
                        InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.grey,
                            child: Text(
                              "View All",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              12.ph,
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
                              style: AppTextStyles.bodyBlack14.copyWith(
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
                              "Shipping Charge",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(1000),
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
                              "Discount",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: Text(
                            Formatter.formatPrice(1000),
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
                              "Grand Total",
                              style: AppTextStyles.bodyBlack14.copyWith(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppColors.profileLabelBg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        color: Colors.grey,
                        child: Text(
                          "A-1, Jaipur Raj,  jhotwara Jaipur",
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
              ),
              12.ph,
              // receive now and pay now buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      isGradient: false,
                      backgroundColor: AppColors.redBtnColor,
                      child: Text(
                        AppStrings.receiveNowTxt.toUpperCase(),
                        style: AppTextStyles.bodyWhite14,
                      ),
                    ),
                  ),
                  16.pw,
                  Expanded(
                    child: CustomButton(
                      onPressed: () {},
                      isGradient: false,
                      backgroundColor: AppColors.greenBtnColor,
                      child: Text(
                        AppStrings.payNowTxt.toUpperCase(),
                        style: AppTextStyles.bodyWhite14,
                      ),
                    ),
                  ),
                ],
              ),
              16.ph,
            ],
          ),
        ),
      ),
    );
  }
}
