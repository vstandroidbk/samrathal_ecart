import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/dashboard/offers/offer_list_screen.dart';
import '../../dashboard_screen.dart';

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
                MaterialPageRoute(
                  builder: (context) => const OfferListScreen(),
                ),
              );
            } else if (labelName == AppStrings.productsTxt) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(selectedTab: 1),
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
