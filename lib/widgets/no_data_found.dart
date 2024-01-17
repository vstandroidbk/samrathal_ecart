import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../core/app_images.dart';
import '../core/app_text_styles.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.noDataImg,
          height: 100,
          width: 100,
        ),
        8.ph,
        Text(
          "No Data found",
          style: AppTextStyles.bodyBlack20,
        ),
      ],
    ));
  }
}
