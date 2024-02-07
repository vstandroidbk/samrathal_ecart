import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../logic/provider/auth/auth_api_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/loader_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String mobile;

  const RegisterScreen({super.key, required this.mobile});

  // static const String routeName = "Register Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  ValueNotifier<int?> selectedValue = ValueNotifier<int?>(1);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppStrings.registerScreenTitle)
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
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.nameLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: nameController,
                  hintText: AppStrings.nameHint,
                  prefixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCaps: TextCapitalization.words,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.passwordLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: passwordController,
                  hintText: AppStrings.passwordHint,
                  prefixIcon: const Icon(Icons.lock),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  showPasswordVisibilityIcon: true,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
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
                ValueListenableBuilder(
                  valueListenable: selectedValue,
                  builder: (BuildContext context, value, Widget? child) {
                    return CustomTextField(
                      textController: confirmPassController,
                      hintText: AppStrings.cnfPasswordHint,
                      prefixIcon: const Icon(Icons.lock),
                      keyboardType: TextInputType.text,
                      textInputAction: selectedValue.value == 1
                          ? TextInputAction.done
                          : TextInputAction.next,
                      showPasswordVisibilityIcon: true,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    );
                  },
                ),
                16.ph,
                SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          selectedValue.value =
                          (selectedValue.value == 1) ? null : 1;
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedValue,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: value,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue.value = value;
                                    });
                                  },
                                ),
                                Text(AppStrings.individualTxt),
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedValue.value =
                          (selectedValue.value == 2) ? null : 2;
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedValue,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: value,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue.value = value;
                                    });
                                  },
                                ),
                                Text(AppStrings.companyTxt),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: selectedValue,
                    builder: (BuildContext context, value, Widget? child) {
                      return Visibility(
                        visible: selectedValue.value == 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.ph,
                            CustomLabelWidget(
                              labelText: AppStrings.companyNameLabel,
                              mandatory: true,
                            ),
                            5.ph,
                            CustomTextField(
                              textController: companyNameController,
                              hintText: AppStrings.companyNameHint,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (selectedValue.value == 2 &&
                                    value!.trim().isEmpty) {
                                  return 'Please enter your company name';
                                }
                                return null;
                              },
                            ),
                            16.ph,
                            CustomLabelWidget(
                              labelText: AppStrings.gstNumberLabel,
                              mandatory: true,
                            ),
                            5.ph,
                            CustomTextField(
                              textController: gstNumberController,
                              hintText: AppStrings.gstNumberHint,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (selectedValue.value == 2 &&
                                    value!.trim().isEmpty) {
                                  return 'Please enter your GST number';
                                }
                                return null;
                              },
                            ),
                            16.ph,
                            CustomLabelWidget(
                              labelText: AppStrings.billingAddressLabel,
                              mandatory: true,
                            ),
                            5.ph,
                            CustomTextField(
                              textController: billingAddressController,
                              hintText: AppStrings.billingAddressHint,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              maxLine: 3,
                              validator: (value) {
                                if (selectedValue.value == 2 &&
                                    value!.trim().isEmpty) {
                                  return 'Please enter your billing address';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                20.ph,
                Consumer<AuthApiProvider>(
                  builder: (BuildContext context, registerUserProvider,
                      Widget? child) {
                    return registerUserProvider.registerLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                      onPressed: () {
                        removeFocus(context);
                        var name = nameController.text.trim();
                        var password = passwordController.text.trim();
                        var companyName =
                        companyNameController.text.trim();
                        var gstNumber = gstNumberController.text.trim();
                        var billingAddress =
                        billingAddressController.text.trim();
                        if (_formKey.currentState!.validate()) {
                          registerUserProvider.registerUser(
                              context: context,
                              name: name,
                              password: password,
                              companyName: companyName,
                              gstNumber: gstNumber,
                              billingAddress: billingAddress,
                              companyType: selectedValue.value!,
                              mobile: widget.mobile);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
