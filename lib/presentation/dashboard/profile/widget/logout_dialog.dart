import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/services/preferences.dart';
import '../../../auth/mobile_verify_screen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                color: AppColors.primaryColor),
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.logoutTxt,
                  style: AppTextStyles.bodyBlack16
                      .copyWith(color: AppColors.whiteColor),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: const Icon(
                //     Icons.close,
                //     color: AppColors.whiteColor,
                //   ),
                // )
              ],
            ).animate().fadeIn(duration: 500.ms),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                25.ph,
                Text(
                  AppStrings.areYouSureTxt,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyBlack16,
                ),
                16.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("NO"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        userLogout(context);
                      },
                      child: const Text("YES"),
                    )
                  ],
                ),
                12.ph,
                /*CustomButton(
                    width: 80,
                    height: 35,
                    onPressed: () {
                      Navigator.of(context).pop();
                      userLogout(context);
                    },
                    isGradient: false,
                    child: Text(
                      "Ok",
                      style: AppTextStyles.bodyBlack14
                          .copyWith(color: Colors.white),
                    ),
                  )*/
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms) /*.animate().scaleX(duration: 500.ms),*/
        ],
      ),
    );

    /*Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  color: AppColors.primaryColor),
              padding:
                  const EdgeInsets.only(left: 12, top: 5, bottom: 5, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.logoutTxt,
                    style: AppTextStyles.bodyBlack16
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ),
                  )
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Column(
                children: [
                  Text(
                    AppStrings.areYouSureTxt,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyBlack16,
                  ),
                  16.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("NO"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("YES"),
                      )
                    ],
                  ),
                  */ /*CustomButton(
                    width: 80,
                    height: 35,
                    onPressed: () {
                      Navigator.of(context).pop();
                      userLogout(context);
                    },
                    isGradient: false,
                    child: Text(
                      "Ok",
                      style: AppTextStyles.bodyBlack14
                          .copyWith(color: Colors.white),
                    ),
                  )*/ /*
                ],
              ),
            ).animate().fadeIn(
                duration: 300.ms) */ /*.animate().scaleX(duration: 500.ms),*/ /*
          ],
        ),
      ),
    );*/
  }

  Future<void> userLogout(BuildContext context) async {
    SharedPrefProvider.clearPreference();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileVerifyScreen(),
        ),
        (route) => false);
  }
}
