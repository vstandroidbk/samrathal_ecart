import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';

class ProfileLoadingShimmer extends StatelessWidget {
  const ProfileLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.grey100,
        highlightColor: AppColors.grey300,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: const BoxDecoration(
            color: AppColors.profileLabelBg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                child: Text(
                  "Mr. Flutter",
                  style: AppTextStyles.bodyBlack16.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              5.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.grey,
                      child: Text(
                        "mr.flutter@gmail.com",
                        style: AppTextStyles.bodyBlack14
                            .copyWith(color: AppColors.profileLabelTxtColor),
                      ),
                    ),
                  ),
                  // Text(
                  //   "Edit",
                  //   style: AppTextStyles.bodyBlack14.copyWith(
                  //       color: AppColors.primaryColor,
                  //       fontWeight: FontWeight.w700),
                  // )
                ],
              ),
              5.ph,
              Container(
                color: Colors.grey,
                child: Text(
                  "1234567890",
                  style: AppTextStyles.bodyBlack14
                      .copyWith(color: AppColors.profileLabelTxtColor),
                ),
              ),
            ],
          ),
        ));
  }
}
