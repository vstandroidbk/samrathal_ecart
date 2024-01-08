import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';

import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key});

  static const String routeName = "Offer Details Screen";

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offer Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppImages.sliderImg3,
              width: double.infinity,
              height: 150,
              fit: BoxFit.fill,
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
                    Text(
                      AppStrings.startDateTxt.toUpperCase(),
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    5.ph,
                    Text(
                      "05 jan 2024",
                      style: AppTextStyles.bodyBlack14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.endDateTxt.toUpperCase(),
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    5.ph,
                    Text(
                      "10 jan 2023",
                      style: AppTextStyles.bodyBlack14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          Text(
            AppStrings.offerTitleTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            "NEW YEAR OFFER ( HOT DIPPED GALVANIZED WIRE )",
            style:
                AppTextStyles.bodyBlack14.copyWith(color: AppColors.descColor),
          ),
          16.ph,
          Text(
            AppStrings.descriptionTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            "Hot dipped galvanized wire belongs to the primary wire products of galvanization. The common sizes of hot dipped galvanized are from 8 gauge to 16 gauge, we also accept smaller or bigger diameter for customers' choices.",
            style:
                AppTextStyles.bodyBlack14.copyWith(color: AppColors.descColor),
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
