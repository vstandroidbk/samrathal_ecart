import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/auth/password_verify_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static const String routeName = "New Password Screen";

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController mobileController = TextEditingController();
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
        title: Text(AppStrings.newPasswordScreenTitle),
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
                AppStrings.newPasswordTitle,
                style: AppTextStyles.headingBlack24,
              ),
              Text(
                AppStrings.newPasswordDesc,
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
              ),
              16.ph,
              CustomLabelWidget(
                labelText: AppStrings.cnfPasswordLabel,
                mandatory: true,
              ),
              5.ph,
              CustomTextField(
                textController: passwordController,
                hintText: AppStrings.cnfPasswordHint,
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                showPasswordVisibilityIcon: true,
              ),
              20.ph,
              CustomButton(
                onPressed: () {
                  removeFocus(context);
                  Navigator.pushNamedAndRemoveUntil(context,
                      PasswordVerifyScreen.routeName, (route) => false);
                },
                isGradient: false,
                child: Text(
                  AppStrings.submitTxt.toUpperCase(),
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
