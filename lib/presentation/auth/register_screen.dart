import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/auth/register_company_screen.dart';
import 'package:samrathal_ecart/presentation/auth/submit_user_details.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "Register Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<int?> selectedValue = ValueNotifier<int?>(null);

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
        title: Text(AppStrings.registerScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                hintText: AppStrings.nameHint,
                prefixIcon: const Icon(Icons.person),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              16.ph,
              CustomLabelWidget(
                labelText: AppStrings.passwordLabel,
                mandatory: true,
              ),
              5.ph,
              CustomTextField(
                hintText: AppStrings.passwordHint,
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
                hintText: AppStrings.cnfPasswordHint,
                prefixIcon: const Icon(Icons.lock),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                showPasswordVisibilityIcon: true,
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
                        builder: (BuildContext context, value, Widget? child) {
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
                        builder: (BuildContext context, value, Widget? child) {
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
                            hintText: AppStrings.companyNameHint,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          16.ph,
                          CustomLabelWidget(
                            labelText: AppStrings.gstNumberLabel,
                            mandatory: true,
                          ),
                          5.ph,
                          CustomTextField(
                            hintText: AppStrings.gstNumberHint,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          16.ph,
                          CustomLabelWidget(
                            labelText: AppStrings.billingAddressLabel,
                            mandatory: true,
                          ),
                          5.ph,
                          CustomTextField(
                            hintText: AppStrings.billingAddressHint,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            maxLine: 3,
                          ),
                        ],
                      ),
                    );
                  }),
              20.ph,
              CustomButton(
                onPressed: () {
                  if (selectedValue.value == null) {
                    Utils.showErrorMsg("Please select a user type", context);
                    return;
                  }
                  Navigator.pushReplacementNamed(
                      context, SubmitUserDetailsScreen.routeName);
                  // if (selectedValue.value == null) {
                  //   Utils.showErrorMsg("Please select a user type", context);
                  //   return;
                  // }
                  // if (selectedValue.value == 1) {
                  //
                  // } else {
                  //   Navigator.pushReplacementNamed(
                  //       context, RegisterCompanyScreen.routeName);
                  // }
                },
                isGradient: false,
                child: Text(
                  AppStrings.nextTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
