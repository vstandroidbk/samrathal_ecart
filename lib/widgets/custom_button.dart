import "package:flutter/material.dart";
import "../core/app_colors.dart";

class CustomButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;
  final Gradient gradient;
  final bool isGradient;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton(
      {Key? key,
      this.borderRadius,
      this.width = double.infinity,
      this.height = 40,
      this.gradient = const LinearGradient(
        colors: [
          Colors.red,
          Colors.blue,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      required this.onPressed,
      required this.child,
      required this.isGradient,
      this.backgroundColor = AppColors.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0.0);
    return Container(
      width: width,
      height: height,
      decoration: isGradient
          ? BoxDecoration(
              gradient: gradient,
              borderRadius: borderRadius,
            )
          : BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
