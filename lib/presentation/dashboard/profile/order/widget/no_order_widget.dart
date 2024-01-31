import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../../core/app_images.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/navigate_anim.dart';
import '../../../dashboard_screen.dart';

class NoOrderWidget extends StatelessWidget {
  const NoOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.noOrderImg),
                5.ph,
                Text(
                  AppStrings.noOrderTxt,
                  style: AppTextStyles.bodyBlack18
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            )),
        Expanded(
            flex: 1,
            child: Center(
              child: CustomButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      FadeAnimatingRoute(
                        route:
                            const DashboardScreen(selectedTab: 1),
                      ),
                      (route) => false);
                },
                isGradient: false,
                child: Text(
                  AppStrings.shopNowTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              ),
            )),
      ],
    );
  }
}
