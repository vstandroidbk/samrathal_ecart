import 'package:flutter/material.dart';
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

  static const String routeName = "Password Verify Screen";

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
        title: Text(AppStrings.passwordVerifyScreenTitle),
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
              ),
              Text(
                AppStrings.verifyPasswordDesc,
                style: AppTextStyles.bodyBlack16,
              ),
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
              ),
              12.ph,
              Center(
                child: Text(
                  AppStrings.appName,
                  style: AppTextStyles.bodyBlack20,
                ),
              ),
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
                      Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName);
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, DashboardScreen.routeName, (route) => false,
                      arguments: 0);
                },
                isGradient: false,
                child: Text(
                  AppStrings.submitTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: TextButton(
                  onPressed: () {
                    removeFocus(context);
                    Navigator.pushNamed(
                        context, LoginOtpVerifyScreen.routeName);
                  },
                  child: Text(AppStrings.loginWithOtpTxt,
                      style: AppTextStyles.bodyBlack16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
