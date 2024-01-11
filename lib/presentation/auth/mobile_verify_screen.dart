import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/logic/services/preferences.dart';
import 'package:samrathal_ecart/presentation/auth/password_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/register_otp_verify_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';
import 'package:samrathal_ecart/widgets/custom_text_field.dart';

import '../../widgets/label_widget.dart';

class MobileVerifyScreen extends StatefulWidget {
  const MobileVerifyScreen({super.key});

  // static const String routeName = "Mobile Verify Screen";

  @override
  State<MobileVerifyScreen> createState() => _MobileVerifyScreenState();
}

class _MobileVerifyScreenState extends State<MobileVerifyScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppStrings.mobileVerifyScreenTitle)
            .animate()
            .fadeIn(duration: 500.ms),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mq.height * 0.08,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    AppStrings.verifyMobileTitle,
                    style: AppTextStyles.headingBlack24,
                  ),
                ).animate().slideX(duration: 500.ms),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    AppStrings.verifyMobileDesc,
                    style: AppTextStyles.bodyBlack16,
                  ),
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
                CustomLabelWidget(
                  labelText: AppStrings.phoneNumberLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: _mobileController,
                  hintText: AppStrings.mobileHint,
                  maxLength: 10,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: AppColors.textHintColor,
                  ),
                  digitOnly: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter mobile no.';
                    }
                    if (value.length < 10) {
                      return 'Invalid mobile number';
                    }
                    return null;
                  },
                ),
                16.ph,
                CustomButton(
                  onPressed: () {
                    var mobile = _mobileController.text.trim();
                    if (_formKey.currentState!.validate()) {
                      if (mobile == "1111111111") {
                        removeFocus(context);
                        SharedPrefProvider.setString(
                            SharedPrefProvider.token, "425435345");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordVerifyScreen(),
                          ),
                        );
                      } else {
                        removeFocus(context);
                        SharedPrefProvider.setString(
                            SharedPrefProvider.token, "425435345");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RegisterOtpVerifyScreen(),
                          ),
                        );
                      }
                    }
                  },
                  isGradient: false,
                  child: Text(
                    AppStrings.nextTxt.toUpperCase(),
                    style: AppTextStyles.bodyWhite16,
                  ),
                ).animate().fadeIn(duration: 500.ms),
                SizedBox(
                  height: mq.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
