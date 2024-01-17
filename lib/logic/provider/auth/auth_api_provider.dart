import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/data/model/user/user_data_model.dart';
import '../../../core/api.dart';
import '../../../core/app_strings.dart';
import '../../../data/model/user/check_user_type_model.dart';
import '../../../data/model/user/forgot_pass_model.dart';
import '../../../data/repository/auth/auth_repository.dart';
import '../../../presentation/auth/new_password_screen.dart';
import '../../../presentation/auth/password_verify_screen.dart';
import '../../../presentation/auth/register_otp_verify_screen.dart';
import '../../../presentation/auth/register_screen.dart';
import '../../../presentation/auth/submit_user_details.dart';
import '../../../presentation/dashboard/dashboard_screen.dart';
import '../../../utils/utils.dart';
import '../../../widgets/navigate_anim.dart';
import '../../services/preferences.dart';

class AuthApiProvider with ChangeNotifier {
  final AuthRepository _userRepository = AuthRepository();

  // Constructor for initialization
  AuthApiProvider() {
    setLoaderFalse();
    setVerifyOtpFalse();
    setResendOtpFalse();
    setResendOtpFalse();
    setVerifyPasswordFalse();
    setChangePassLoaderFalse();
  }

  // check user type api call ---->>
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> checkUserType(
      {required String mobile, required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setLoading(true);
    // Make the API call
    try {
      CheckUserTypeModel? userModel =
          await _userRepository.checkUserType(mobile: mobile);
      log("api check User Type success ${userModel?.userData?.userType}");
      if (userModel != null &&
          userModel.userData != null &&
          userModel.userData!.userType != null) {
        if (userModel.userData!.userType == 1) {
          Future.delayed(const Duration(milliseconds: 0), () {
            Navigator.push(
              context,
              FadeAnimatingRoute(
                route: PasswordVerifyScreen(
                  mobile: mobile,
                ),
              ),
            );
          });
        } else if (userModel.userData!.userType == 2) {
          Future.delayed(const Duration(milliseconds: 0), () {
            Navigator.push(
              context,
              FadeAnimatingRoute(
                route: RegisterOtpVerifyScreen(
                  fromScreen: AppStrings.fromVerifyMobileScreen,
                  userType: userModel.userData!.userType!,
                  mobile: mobile,
                ),
              ),
            );
          });
        }
      }
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setLoading(false);
    }
  }

  setLoaderFalse() {
    _loading = false;
  }

  // verify OTP api call ---->>

  bool _verifyOtpLoading = false;

  bool get verifyOtpLoading => _verifyOtpLoading;

  setVerifyOtpLoading(bool value) {
    _verifyOtpLoading = value;
    notifyListeners();
  }

  Future<void> verifyOtp(
      {required String mobile,
      required BuildContext context,
      required String fromScreen,
      required int userType,
      required String otp}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setVerifyOtpLoading(true);
    // Make the API call
    try {
      UserDataModel? userDataModel = await _userRepository.verifyOtp(
          mobile: mobile, userType: userType, otp: otp);
      if (fromScreen == AppStrings.fromLoginScreen && userType == 1) {
        if (userDataModel != null &&
            userDataModel.userData != null &&
            userDataModel.userData?.userId != null) {
          await SharedPrefProvider.setString(
              SharedPrefProvider.userId, userDataModel.userData!.userId!);
          await SharedPrefProvider.setString(
              SharedPrefProvider.mobile, userDataModel.userData!.mobileNumber!);
          Future.delayed(const Duration(milliseconds: 0), () {
            Navigator.pushAndRemoveUntil(
              context,
              FadeAnimatingRoute(
                route: const DashboardScreen(selectedTab: 0),
              ),
              (route) => false,
            );
          });
        }
      } else if (fromScreen == AppStrings.fromVerifyMobileScreen &&
          userType == 2) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushReplacement(
            context,
            FadeAnimatingRoute(
              route: RegisterScreen(
                mobile: mobile,
              ),
            ),
          );
        });
      } else if (fromScreen == AppStrings.fromForgetScreen) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewPasswordScreen(
                userType: userType,
                mobile: mobile,
                fromScreen: fromScreen,
              ),
            ),
          );
        });
      }
      log("api verify OTP success");
    } catch (ex) {
      log("api verify OTP error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setVerifyOtpLoading(false);
    }
  }

  setVerifyOtpFalse() {
    _verifyOtpLoading = false;
  }

  // resend otp api call ---->>

  bool _resendOtpLoading = false;

  bool get resendOtpLoading => _resendOtpLoading;

  setResendOtpLoading(bool value) {
    _resendOtpLoading = value;
    notifyListeners();
  }

  Future<bool> resendOtp(
      {required String mobile,
      required String from,
      required BuildContext context,
      int? userType,
      String? fromScreen}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return false;
    }
    setResendOtpLoading(true);
    // Make the API call
    try {
      var sendOtp = await _userRepository.resendOtp(mobile: mobile);
      if (sendOtp != null && sendOtp) {
        if (from == AppStrings.fromLoginScreen) {
          Future.delayed(const Duration(milliseconds: 0), () {
            Navigator.push(
              context,
              FadeAnimatingRoute(
                route: RegisterOtpVerifyScreen(
                    userType: userType!,
                    fromScreen: AppStrings.fromLoginScreen,
                    mobile: mobile),
              ),
            );
          });
        }
      }
      log("api verify OTP success");
      return true;
    } catch (ex) {
      log("api verify OTP error $ex");
      Utils.showToast(ex.toString());
      return false;
    } finally {
      // After completion (success/failure), set isLoading to false
      setResendOtpLoading(false);
    }
  }

  setResendOtpFalse() {
    _resendOtpLoading = false;
  }

  // register user api call ---->>
  bool _registerLoading = false;

  bool get registerLoading => _registerLoading;

  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  Future<void> registerUser({
    required String mobile,
    required String name,
    required String password,
    required String companyName,
    required String gstNumber,
    required String billingAddress,
    required int companyType,
    required BuildContext context,
  }) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setRegisterLoading(true);
    // Make the API call
    try {
      UserDataModel? userDataModel = await _userRepository.registerUser(
          name: name,
          password: password,
          companyName: companyName,
          gstNumber: gstNumber,
          billingAddress: billingAddress,
          companyType: companyType,
          mobile: mobile);
      log("api register user success ${userDataModel?.userData}");
      if (userDataModel != null &&
          userDataModel.userData != null &&
          userDataModel.userData!.userId != null) {
        await SharedPrefProvider.setString(
            SharedPrefProvider.userId, userDataModel.userData!.userId!);
        await SharedPrefProvider.setString(
            SharedPrefProvider.mobile, userDataModel.userData!.mobileNumber!);
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushAndRemoveUntil(
              context,
              FadeAnimatingRoute(
                route: const SubmitUserDetailsScreen(),
              ),
              (route) => false);
        });
      }
    } catch (ex) {
      log("api register user error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setRegisterLoading(false);
    }
  }

  setRegisterLoaderFalse() {
    _registerLoading = false;
  }

  // verify Password api call ---->>

  bool _verifyPasswordLoading = false;

  bool get verifyPasswordLoading => _verifyPasswordLoading;

  setVerifyPasswordLoading(bool value) {
    _verifyPasswordLoading = value;
    notifyListeners();
  }

  Future<void> loginWithPassword(
      {required String mobile,
      required String password,
      required BuildContext context}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setVerifyPasswordLoading(true);
    // Make the API call
    try {
      UserDataModel? userDataModel = await _userRepository.verifyPassword(
          mobile: mobile, password: password);
      if (userDataModel != null &&
          userDataModel.userData != null &&
          userDataModel.userData?.userId != null) {
        await SharedPrefProvider.setString(
            SharedPrefProvider.userId, userDataModel.userData!.userId!);
        await SharedPrefProvider.setString(
            SharedPrefProvider.mobile, userDataModel.userData!.mobileNumber!);
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushAndRemoveUntil(
            context,
            FadeAnimatingRoute(
              route: const DashboardScreen(selectedTab: 0),
            ),
            (route) => false,
          );
        });
      }
      log("api verify OTP success");
    } catch (ex) {
      log("api verify OTP error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setVerifyPasswordLoading(false);
    }
  }

  setVerifyPasswordFalse() {
    _verifyPasswordLoading = false;
  }

  // forgot password api call ---->>
  bool _forgotPassLoading = false;

  bool get forgotPassLoading => _forgotPassLoading;

  setForgotLoading(bool value) {
    _forgotPassLoading = value;
    notifyListeners();
  }

  Future<void> forgotPassword(
      {required String mobile,
      required BuildContext context,
      required String fromScreen}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setForgotLoading(true);
    // Make the API call
    try {
      ForgotPasswordModel? forgotPasswordModel =
          await _userRepository.forgotPassword(mobile: mobile);
      log("api change password success ${forgotPasswordModel?.otpData?.otp}");
      if (forgotPasswordModel != null &&
          forgotPasswordModel.otpData != null &&
          forgotPasswordModel.otpData!.otp != null) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.push(
            context,
            FadeAnimatingRoute(
              route: RegisterOtpVerifyScreen(
                fromScreen: fromScreen,
                userType: 2,
                mobile: mobile,
              ),
            ),
          );
        });
      }
    } catch (ex) {
      log("api change password error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setForgotLoading(false);
    }
  }

  setForgotLoaderFalse() {
    _forgotPassLoading = false;
  }

  // change password api call ---->>
  bool _changePassLoading = false;

  bool get changePassLoading => _changePassLoading;

  setChangePassLoading(bool value) {
    _changePassLoading = value;
    notifyListeners();
  }

  Future<void> changePassword(
      {required String mobile,
      required BuildContext context,
      required String password}) async {
    // set isLoading to true to show the loader
    bool isOnline = await Api.hasNetwork();
    if (!isOnline) {
      Utils.showToast(AppStrings.noInternet);
      return;
    }
    setChangePassLoading(true);
    // Make the API call
    try {
      var changePass = await _userRepository.changePassword(
          mobile: mobile, password: password);
      if (changePass != null && changePass) {
        Future.delayed(const Duration(milliseconds: 0), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PasswordVerifyScreen(mobile: mobile),
              ),
              (route) => false);
        });
      }
      log("api check User Type success $changePass");
    } catch (ex) {
      log("api login error $ex");
      Utils.showToast(ex.toString());
    } finally {
      // After completion (success/failure), set isLoading to false
      setChangePassLoading(false);
    }
  }

  setChangePassLoaderFalse() {
    _changePassLoading = false;
  }
}
