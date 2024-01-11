import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/dashboard/dashboard_screen.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../widgets/custom_button.dart';

class OrderSuccessScreen extends StatefulWidget {
  // static const String routeName = "Success Screen";

  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onBackPressed();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset(AppImages.successLottie),
            Center(
              child: Text(
                "Order Received Successfully",
                style: AppTextStyles.bodyWhite20,
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          child: CustomButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(selectedTab: 0),
                  ),
                  (route) => false);
            },
            isGradient: false,
            child: Text(
              AppStrings.continueTxt.toUpperCase(),
              style: AppTextStyles.bodyWhite16,
            ),
          ),
        ),
      ),
    );
  }

  bool onBackPressed() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(selectedTab: 0),
        ),
        (route) => false);
    return true;
  }
}
