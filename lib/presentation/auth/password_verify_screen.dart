import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/presentation/auth/forgot_password_screen.dart';
import 'package:samrathal_ecart/presentation/auth/login_otp_verify_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/dashboard_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';

class PasswordVerifyScreen extends StatefulWidget {
  const PasswordVerifyScreen({super.key});

  // static const String routeName = "Password Verify Screen";

  @override
  State<PasswordVerifyScreen> createState() => _PasswordVerifyScreenState();
}

class _PasswordVerifyScreenState extends State<PasswordVerifyScreen> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        /*leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),*/
        centerTitle: true,
        title: Text(AppStrings.passwordVerifyScreenTitle)
            .animate()
            .fadeIn(duration: 500.ms),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.08,
              ),
              Text(
                AppStrings.verifyPasswordTitle,
                style: AppTextStyles.headingBlack24,
              ).animate().slideX(duration: 500.ms),
              Text(
                AppStrings.verifyPasswordDesc,
                style: AppTextStyles.bodyBlack16,
              ).animate().slideX(duration: 500.ms),
              SizedBox(
                height: mq.height * 0.08,
              ),
              Center(
                child: Image.asset(
                  AppImages.loginLogo,
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ).animate().fadeIn(duration: 500.ms),
              12.ph,
              Center(
                child: Text(
                  AppStrings.appName,
                  style: AppTextStyles.bodyBlack20,
                ),
              ).animate().fadeIn(duration: 500.ms),
              SizedBox(
                height: mq.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLabelWidget(
                    labelText: AppStrings.passwordLabel,
                    mandatory: true,
                  ),
                  InkWell(
                    onTap: () {
                      removeFocus(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppStrings.forgotPasswordTxt,
                      style: AppTextStyles.bodyBlack16
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
              5.ph,
              CustomTextField(
                textController: passwordController,
                hintText: AppStrings.passwordHint,
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                showPasswordVisibilityIcon: true,
              ),
              16.ph,
              CustomButton(
                onPressed: () {
                  removeFocus(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DashboardScreen(selectedTab: 0),
                    ),
                    (route) => false,
                  );
                },
                isGradient: false,
                child: Text(
                  AppStrings.submitTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              ).animate().fadeIn(duration: 500.ms),
              8.ph,
              Align(
                alignment: AlignmentDirectional.center,
                child: TextButton(
                  onPressed: () {
                    removeFocus(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginOtpVerifyScreen(),
                      ),
                    );
                  },
                  child: Text(AppStrings.loginWithOtpTxt,
                      style: AppTextStyles.bodyBlack16),
                ),
              ).animate().fadeIn(duration: 500.ms)
            ],
          ),
        ),
      ),
    );
  }
}
