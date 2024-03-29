import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class CustomParagraph extends StatefulWidget {
  final String description;

  const CustomParagraph({super.key, required this.description});

  @override
  State<CustomParagraph> createState() => _CustomParagraphState();
}

class _CustomParagraphState extends State<CustomParagraph> {
  bool showMore = false;
  late TapGestureRecognizer showMoreRecognizer;

  @override
  void initState() {
    showMoreRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showMore = !showMore;
        });
      };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    showMoreRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [
        TextSpan(
          text: showMore
              ? widget.description
              : widget.description.length < 100
                  ? widget.description
                  : "${widget.description.substring(0, 100)}...",
          style: AppTextStyles.bodyBlack14.copyWith(color: AppColors.descColor),
        ),
        if (widget.description.length > 100)
          TextSpan(
            recognizer: showMoreRecognizer,
            text: showMore ? "Show Less" : "Read More",
            style: AppTextStyles.bodyBlack14
                .copyWith(color: AppColors.primaryColor),
          ),
      ]),
    );
  }
}
