import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/edit_address_page.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';

class AddressViewCard extends StatelessWidget {
  final int index;

  const AddressViewCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (index == 0)
          Container(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Text(
              "Primary",
              style: AppTextStyles.bodyWhite12,
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
                    child: Text(
                      "212-B Abc nagar def road ghk area 123456",
                      style: AppTextStyles.bodyBlack14,
                    ),
                  ),
                  8.pw,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditAddressPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
