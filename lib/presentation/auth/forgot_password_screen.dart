import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/auth/forgot_pass_otp_verify_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = "Forgot Password Screen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileController = TextEditingController();

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
        title: Text(AppStrings.forgotPasswordScreenTitle),
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
                AppStrings.forgotPasswordTitle,
                style: AppTextStyles.headingBlack24,
              ),
              Text(
                AppStrings.forgotPasswordDesc,
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
              CustomLabelWidget(
                labelText: AppStrings.phoneNumberLabel,
                mandatory: true,
              ),
              5.ph,
              CustomTextField(
                textController: mobileController,
                hintText: AppStrings.mobileHint,
                prefixIcon: const Icon(
                  Icons.phone,
                  color: AppColors.textHintColor,
                ),
                digitOnly: true,
              ),
              16.ph,
              CustomButton(
                onPressed: () {
                  removeFocus(context);
                  Navigator.pushNamed(
                      context, ForgotPassOtpVerifyScreen.routeName);
                },
                isGradient: false,
                child: Text(
                  AppStrings.nextTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              ),
              SizedBox(
                height: mq.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
