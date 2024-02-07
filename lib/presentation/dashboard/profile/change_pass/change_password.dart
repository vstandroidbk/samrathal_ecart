import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:samrathal_ecart/widgets/loader_widget.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/dashboard_api_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/label_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setLoaderFalse();
    super.initState();
  }

  Future<void> setLoaderFalse() async {
    var addressProvider =
        Provider.of<DashboardApiProvider>(context, listen: false);
    addressProvider.setUpdatePassLoaderFalse();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.changePassTxt).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLabelWidget(
                  labelText: AppStrings.oldPasswordLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: oldPasswordController,
                  hintText: AppStrings.oldPasswordHint,
                  prefixIcon: const Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  showPasswordVisibilityIcon: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter old password';
                    }
                    return null;
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.newPasswordLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: newPasswordController,
                  hintText: AppStrings.newPasswordHint,
                  prefixIcon: const Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  showPasswordVisibilityIcon: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value == oldPasswordController.text) {
                      return 'New password must be different from the old password';
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
                    if (value!.trim().isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != newPasswordController.text) {
                      return 'Confirm password must be same as new password';
                    }
                    return null;
                  },
                ),
                20.ph,
                Consumer<DashboardApiProvider>(
                  builder: (BuildContext context,
                      DashboardApiProvider dashProvider, Widget? child) {
                    return dashProvider.updatePassLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () {
                              removeFocus(context);
                              var oldPassword =
                                  oldPasswordController.text.trim();
                              var newPassword =
                                  newPasswordController.text.trim();
                              if (_formKey.currentState!.validate()) {
                                dashProvider.updatePassword(
                                    oldPass: oldPassword,
                                    context: context,
                                    newPass: newPassword);
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
