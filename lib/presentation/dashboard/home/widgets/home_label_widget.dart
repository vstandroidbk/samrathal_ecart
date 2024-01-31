import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/navigate_anim.dart';
import '../../dashboard_screen.dart';
import '../../offers/offer_list_screen.dart';

class HomeLabelWidget extends StatelessWidget {
  final String labelName;

  const HomeLabelWidget({Key? key, required this.labelName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelName,
          style:
              AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w700),
        ),
        InkWell(
          onTap: () {
            if (labelName == AppStrings.offersTxt) {
              Navigator.push(
                context,
                FadeAnimatingRoute(
            route: const OfferListScreen(),
                ),
              );
            } else if (labelName == AppStrings.productsTxt) {
              Navigator.pushAndRemoveUntil(
                  context,
                  FadeAnimatingRoute(
                    route: const DashboardScreen(selectedTab: 1),
                  ),
                  (route) => false);
            }
          },
          child: Text(
            AppStrings.seeAllTxt,
            style: AppTextStyles.bodyBlack14.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
