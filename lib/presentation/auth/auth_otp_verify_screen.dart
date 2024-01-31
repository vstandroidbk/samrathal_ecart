import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../logic/provider/auth/auth_api_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/loader_widget.dart';

class AuthOtpVerifyScreen extends StatefulWidget {
  final String fromScreen;
  final String mobile;
  final int userType;

  const AuthOtpVerifyScreen(
      {super.key,
      required this.userType,
      required this.fromScreen,
      required this.mobile});

  @override
  State<AuthOtpVerifyScreen> createState() => _AuthOtpVerifyScreenState();
}

class _AuthOtpVerifyScreenState extends State<AuthOtpVerifyScreen> {
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
        title: Text(AppStrings.otpVerifyScreenTitle)
            .animate()
            .fadeIn(duration: 500.ms),
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
              ).animate().slideX(duration: 500.ms),
              Text(
                "${AppStrings.verifyOtpDesc} ${widget.mobile.replaceRange(0, 7, "*******")}",
                style: AppTextStyles.bodyBlack16,
              ).animate().slideX(duration: 500.ms),
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
              ).animate().fadeIn(duration: 500.ms),
              8.ph,
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
                labelText: AppStrings.otpLabel,
                mandatory: true,
              ),
              8.ph,
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 45,
                  fieldWidth: 45,
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
                  var provider = Provider.of<AuthApiProvider>(
                    context,
                    listen: false,
                  );
                  await provider.verifyOtp(
                      mobile: widget.mobile,
                      context: context,
                      fromScreen: widget.fromScreen,
                      userType: widget.userType,
                      otp: otpController.text);
                  otpController.clear();
                },
                hintCharacter: "-",
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  log("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
              ),
              16.ph,
              Consumer<AuthApiProvider>(
                builder:
                    (BuildContext context, checkUserProvider, Widget? child) {
                  return checkUserProvider.verifyOtpLoading
                      ? const CustomButtonLoader()
                      : CustomButton(
                          onPressed: () {
                            if (otpController.text.trim().isEmpty) {
                              Utils.showToast("Please enter OTP");
                            }
                          },
                          isGradient: false,
                          child: Text(
                            AppStrings.verifyTxt.toUpperCase(),
                            style: AppTextStyles.bodyWhite16,
                          ),
                        ).animate().fadeIn(duration: 500.ms);
                },
              ),
              12.ph,
              ValueListenableBuilder(
                valueListenable: _timerNotifier,
                builder: (BuildContext context, int value, Widget? child) {
                  return timerWidget(value);
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

  Widget timerWidget(int value) {
    return value == 0
        ? Align(
            alignment: AlignmentDirectional.center,
            child: InkWell(
              onTap: () async {
                bool otpResp = await Provider.of<AuthApiProvider>(
                  context,
                  listen: false,
                ).resendOtp(
                    mobile: widget.mobile,
                    from: AppStrings.fromOtpScreen,
                    context: context);
                if (otpResp) {
                  log("resend data after $otpResp");
                  startTimer();
                }
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
  }
}
