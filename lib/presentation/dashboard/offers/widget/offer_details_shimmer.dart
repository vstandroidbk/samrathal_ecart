import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';

class OfferDetailsShimmer extends StatelessWidget {
  const OfferDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey,
            ),
          ),
          //
          16.ph,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey,
                      child: Text(
                        AppStrings.startDateTxt.toUpperCase(),
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    5.ph,
                    Container(
                      color: Colors.grey,
                      child: Text(
                        "05 jan 2024",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.grey,
                      child: Text(
                        AppStrings.endDateTxt.toUpperCase(),
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    5.ph,
                    Container(
                      color: Colors.grey,
                      child: Text(
                        "10 jan 2023",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          Container(
            color: Colors.grey,
            child: Text(
              AppStrings.offerTitleTxt,
              style: AppTextStyles.bodyBlack14
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          5.ph,
          Container(
            color: Colors.grey,
            child: Text(
              "NEW YEAR OFFER ( HOT DIPPED GALVANIZED WIRE )",
              style: AppTextStyles.bodyBlack14
                  .copyWith(color: AppColors.descColor),
            ),
          ),
          16.ph,
          Container(
            color: Colors.grey,
            child: Text(
              AppStrings.descriptionTxt,
              style: AppTextStyles.bodyBlack14
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          5.ph,
          Container(
            color: Colors.grey,
            child: Text(
              "Hot dipped galvanized wire belongs to the primary wire products of galvanization. The common sizes of hot dipped galvanized are from 8 gauge to 16 gauge, we also accept smaller or bigger diameter for customers' choices.",
              style: AppTextStyles.bodyBlack14
                  .copyWith(color: AppColors.descColor),
            ),
          ),
          20.ph,
          CustomButton(
            onPressed: () {},
            isGradient: false,
            child: Text(
              AppStrings.optOfferTxt,
              style: AppTextStyles.bodyWhite14,
            ),
          )
        ],
      ),
    );
  }
}
