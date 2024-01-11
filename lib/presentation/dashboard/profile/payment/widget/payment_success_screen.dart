import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/dashboard/dashboard_screen.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../widgets/custom_button.dart';

class PaymentSuccessScreen extends StatefulWidget {
  // static const String routeName = "Payment Success Screen";

  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
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
                "Order Payment Successful",
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
    // Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(selectedTab: 0),
        ),
        (route) => false);
    return true;
  }
}
