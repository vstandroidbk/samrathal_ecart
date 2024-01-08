import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/auth/mobile_verify_screen.dart';
import '../core/api.dart';
import '../core/app_images.dart';
import '../logic/services/preferences.dart';
import '../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "Splash Screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void openScreen() async {
    final token = await SharedPrefProvider.getString(SharedPrefProvider.token);
    final isOnline = await Api.hasNetwork();

    if (isOnline) {
      if (token != null && token.isNotEmpty) {
        // Future.delayed(const Duration(milliseconds: 1500), () async {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, DashboardScreen.routeName, (route) => false);
        // });
      } else {
        Future.delayed(const Duration(milliseconds: 1500), () async {
          Navigator.pushNamedAndRemoveUntil(
              context, MobileVerifyScreen.routeName, (route) => false);
        });
      }
    } else {
      Utils.showToast(AppStrings.noInternet);
    }
  }

  @override
  void initState() {
    super.initState();
    openScreen();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.loginLogo,
                  fit: BoxFit.fill,
                  height: 80,
                  color: Colors.white,
                  width: 80,
                ),
                12.ph,
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.headingWhite24,
                )
              ],
            ),
          ),
          Positioned(
            bottom: mq.height / 9,
            width: mq.width,
            child: const SpinKitCircle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
