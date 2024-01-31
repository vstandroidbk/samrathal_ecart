import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class CustomLabelWidget extends StatelessWidget {
  final String labelText;
  final Color textColor;
  final TextAlign textAlign;
  final bool mandatory;
  final double fontSize;

  const CustomLabelWidget(
      {Key? key,
      required this.labelText,
      this.textColor = AppColors.textBlackColor,
      this.textAlign = TextAlign.start,
      this.mandatory = false,
      this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: labelText,
        style: AppTextStyles.bodyBlack14.copyWith(fontSize: fontSize),
        children: [
          TextSpan(
            text: mandatory ? '*' : '',
            style: AppTextStyles.bodyBlack14
                .copyWith(color: AppColors.primaryColor, fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
