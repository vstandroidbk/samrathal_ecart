import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_images.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';

class UploadImageShimmer extends StatelessWidget {
  const UploadImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey300,
      highlightColor: AppColors.grey100,
      child: Container(
        height: 45,
        padding: const EdgeInsets.only(left: 12, right: 8),
        decoration: const BoxDecoration(color: AppColors.textFieldBgColor),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  color: Colors.grey,
                  child: Text(
                    AppStrings.uploadScreenshotTxt,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(color: AppColors.textHintColor),
                  ),
                ),
              ),
              8.pw,
              Container(
                color: Colors.grey,
                child: Image.asset(
                  AppImages.uploadImg,
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
