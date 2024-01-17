import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../logic/provider/auth/auth_api_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/loader_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  final String fromScreen;
  final String mobile;
  final int userType;

  const NewPasswordScreen(
      {super.key,
      required this.userType,
      required this.mobile,
      required this.fromScreen});

  // static const String routeName = "New Password Screen";

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        title: Text(AppStrings.newPasswordScreenTitle)
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
                  AppStrings.newPasswordTitle,
                  style: AppTextStyles.headingBlack24,
                ).animate().slideX(duration: 500.ms),
                Text(
                  AppStrings.newPasswordDesc,
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
                  labelText: AppStrings.newPasswordLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: passwordController,
                  hintText: AppStrings.newPasswordHint,
                  prefixIcon: const Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  showPasswordVisibilityIcon: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.cnfPasswordLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: confirmPasswordController,
                  hintText: AppStrings.cnfPasswordHint,
                  prefixIcon: const Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  showPasswordVisibilityIcon: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                20.ph,
                Consumer<AuthApiProvider>(
                  builder: (BuildContext context, changePassProvider,
                      Widget? child) {
                    return changePassProvider.changePassLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () {
                              removeFocus(context);
                              var password = passwordController.text.trim();
                              if (_formKey.currentState!.validate()) {
                                changePassProvider.changePassword(
                                    mobile: widget.mobile,
                                    context: context,
                                    password: password);
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
