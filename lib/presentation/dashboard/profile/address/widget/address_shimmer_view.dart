import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';

class AddressShimmerView extends StatelessWidget {
  const AddressShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.grey100,
          highlightColor: AppColors.grey300,
          child: Stack(
            children: [
              if (index == 0)
                Container(
                  decoration:
                      const BoxDecoration(color: AppColors.primaryColor),
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, top: 2, bottom: 2),
                  child: Text(
                    "Primary",
                    style: AppTextStyles.bodyWhite12,
                  ),
                ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 12),
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
                              "212-B Abc nagar def road ghk area 123456",
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          color: Colors.grey,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Edit",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
