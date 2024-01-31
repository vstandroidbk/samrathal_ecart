import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../logic/provider/auth/auth_api_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/loader_widget.dart';
import '../../widgets/navigate_anim.dart';
import 'forgot_password_screen.dart';

class PasswordVerifyScreen extends StatefulWidget {
  final String mobile;

  const PasswordVerifyScreen({super.key, required this.mobile});

  // static const String routeName = "Password Verify Screen";

  @override
  State<PasswordVerifyScreen> createState() => _PasswordVerifyScreenState();
}

class _PasswordVerifyScreenState extends State<PasswordVerifyScreen> {
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
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
                          FadeAnimatingRoute(
                            route: ForgotPasswordScreen(
                              mobile: widget.mobile,
                            ),
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
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                16.ph,
                Consumer<AuthApiProvider>(
                  builder:
                      (BuildContext context, passwordProvider, Widget? child) {
                    return passwordProvider.verifyPasswordLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () {
                              var password = passwordController.text.trim();
                              removeFocus(context);
                              if (_formKey.currentState!.validate()) {
                                passwordProvider.loginWithPassword(
                                    context: context,
                                    password: password,
                                    mobile: widget.mobile);
                              }
                            },
                            isGradient: false,
                            child: Text(
                              AppStrings.submitTxt.toUpperCase(),
                              style: AppTextStyles.bodyWhite16,
                            ),
                          ).animate().fadeIn(duration: 500.ms);
                  },
                ),
                8.ph,
                Consumer<AuthApiProvider>(
                  builder:
                      (BuildContext context, passwordProvider, Widget? child) {
                    return passwordProvider.resendOtpLoading
                        ? const CustomButtonLoader()
                        : Align(
                            alignment: AlignmentDirectional.center,
                            child: TextButton(
                              onPressed: () {
                                removeFocus(context);
                                passwordProvider.resendOtp(
                                    context: context,
                                    mobile: widget.mobile,
                                    from: AppStrings.fromLoginScreen,
                                    userType: 1,
                                    fromScreen: AppStrings.fromLoginScreen);
                              },
                              child: Text(AppStrings.loginWithOtpTxt,
                                  style: AppTextStyles.bodyBlack16),
                            ),
                          ).animate().fadeIn(duration: 500.ms);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
