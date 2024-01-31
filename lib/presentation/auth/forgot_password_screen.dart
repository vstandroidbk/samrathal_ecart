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

class ForgotPasswordScreen extends StatefulWidget {
  final String mobile;

  const ForgotPasswordScreen({super.key, required this.mobile});

  // static const String routeName = "Forgot Password Screen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    mobileController.text = widget.mobile;
    super.initState();
  }

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
        title: Text(AppStrings.forgotPasswordScreenTitle)
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
                  AppStrings.forgotPasswordTitle,
                  style: AppTextStyles.headingBlack24,
                ).animate().slideX(duration: 500.ms),
                Text(
                  AppStrings.forgotPasswordDesc,
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
                CustomLabelWidget(
                  labelText: AppStrings.phoneNumberLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: mobileController,
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
                    if (value!.trim().isEmpty) {
                      return 'Please enter mobile no.';
                    }
                    if (value.length < 10) {
                      return 'Invalid mobile number';
                    }
                    return null;
                  },
                ),
                16.ph,
                16.ph,
                Consumer<AuthApiProvider>(
                  builder:
                      (BuildContext context, checkUserProvider, Widget? child) {
                    return checkUserProvider.forgotPassLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () {
                              removeFocus(context);
                              var mobile = mobileController.text.trim();
                              if (_formKey.currentState!.validate()) {
                                checkUserProvider.forgotPassword(
                                    mobile: mobile,
                                    context: context,
                                    fromScreen: AppStrings.fromForgetScreen);
                              }
                            },
                            isGradient: false,
                            child: Text(
                              AppStrings.nextTxt.toUpperCase(),
                              style: AppTextStyles.bodyWhite16,
                            ),
                          ).animate().fadeIn(duration: 500.ms);
                  },
                ),
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
