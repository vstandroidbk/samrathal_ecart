import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';

class ProfileLabelWidget extends StatelessWidget {
  final String labelName;

  const ProfileLabelWidget({Key? key, required this.labelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: const BoxDecoration(
        color: AppColors.profileLabelBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelName,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w600),
          ),
          const Icon(
            Icons.navigate_next,
            size: 18,
          ),
        ],
      ),
    );
  }
}
