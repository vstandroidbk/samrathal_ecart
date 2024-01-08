import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/presentation/auth/new_password_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/label_widget.dart';

class ForgotPassOtpVerifyScreen extends StatefulWidget {
  const ForgotPassOtpVerifyScreen({super.key});

  static const String routeName = "Forgot Pass Otp Verify";

  @override
  State<ForgotPassOtpVerifyScreen> createState() =>
      _ForgotPassOtpVerifyScreenState();
}

class _ForgotPassOtpVerifyScreenState extends State<ForgotPassOtpVerifyScreen> {
  TextEditingController otpController = TextEditingController();

  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(30);

  void startTimer() {
    _timerNotifier.value = 30;
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_timerNotifier.value == 0) {
        timer.cancel();
      } else {
        _timerNotifier.value--;
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppStrings.otpVerifyScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * 0.08,
              ),
              Text(
                AppStrings.verifyOtpTitle,
                style: AppTextStyles.headingBlack24,
              ),
              Text(
                "${AppStrings.verifyOtpDesc} ${"9876543210".replaceRange(0, 7, "*******")}",
                style: AppTextStyles.bodyBlack16,
              ),
              SizedBox(
                height: mq.height * 0.08,
              ),
              Center(
                child: Image.asset(
                  AppImages.otpLogo,
                  fit: BoxFit.fill,
                  height: 80,
                  width: 80,
                ),
              ),
              8.ph,
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
                labelText: AppStrings.otpLabel,
                mandatory: true,
              ),
              8.ph,
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: AppColors.textFieldBgColor,
                  inactiveFillColor: AppColors.textFieldBgColor,
                  selectedFillColor: AppColors.textFieldBgColor,
                  errorBorderColor: Colors.transparent,
                  activeColor: AppColors.textFieldBgColor,
                  inactiveColor: AppColors.textFieldBgColor,
                  selectedColor: AppColors.textFieldBgColor,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: otpController,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                cursorColor: AppColors.textBlackColor,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                onCompleted: (value) async {
                  // Map<String, dynamic> otpBody = {
                  //   "mobileNumber": widget.mobileNumber,
                  //   "otp": value,
                  //   "login_verify": true,
                  //   "type": 2
                  // };
                  // var provider = Provider.of<LoginController>(
                  //   context,
                  //   listen: false,
                  // );
                  // await provider.verifyLoginOtp(
                  //     context, otpBody, widget.from);
                  // otpController.clear();
                },
                hintCharacter: "-",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
              16.ph,
              CustomButton(
                onPressed: () {
                  removeFocus(context);
                  Navigator.pushReplacementNamed(
                      context, NewPasswordScreen.routeName);
                },
                isGradient: false,
                child: Text(
                  AppStrings.verifyTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              ),
              12.ph,
              ValueListenableBuilder(
                valueListenable: _timerNotifier,
                builder: (BuildContext context, int value, Widget? child) {
                  return value == 0
                      ? Align(
                          alignment: AlignmentDirectional.center,
                          child: InkWell(
                            onTap: () async {
                              // var jsonData = {
                              //   "mobileNumber": widget.mobileNumber,
                              //   "type": 2
                              // };
                              // await resendData.resendLoginOtp(
                              //   context,
                              //   jsonData,
                              // );
                              // log("resend data before ${resendData.resend}");
                              // if (resendData.resend) {
                              //   log("resend data after ${resendData.resend}");
                              //   startTimer();
                              // }
                            },
                            child: Text(
                              AppStrings.resendOtpTxt.toUpperCase(),
                              textAlign: TextAlign.end,
                              style: AppTextStyles.bodyBlack16,
                            ),
                          ),
                        )
                      : Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'Resend OTP in $value seconds',
                            style: AppTextStyles.bodyBlack16,
                          ),
                        );
                },
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
