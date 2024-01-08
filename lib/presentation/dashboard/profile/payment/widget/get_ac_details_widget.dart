import 'package:flutter/material.dart';

import '../../../../../core/app_text_styles.dart';

class GetAcDetailsWidget extends StatelessWidget {
  final String title;
  final String value;

  const GetAcDetailsWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style:
              AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
        )),
        Expanded(
            child: Text(
          value,
          textAlign: TextAlign.right,
          style:
              AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
        )),
      ],
    );
  }
}
