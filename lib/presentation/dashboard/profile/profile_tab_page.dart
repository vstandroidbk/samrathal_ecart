import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/dashboard_api_provider.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/change_pass/change_password.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_list_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/widget/logout_dialog.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/widget/profile_label_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/widget/profile_loading_shimmer.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var addressProvider =
        Provider.of<DashboardApiProvider>(context, listen: false);
    addressProvider.setProfileDataNull();
    await addressProvider.getProfileDataApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        titleSpacing: 12,
        title: Row(
          children: [
            Text(AppStrings.appName),
          ],
        ).animate().fadeIn(duration: 500.ms),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        children: [
          // top name email and mobile edit...
          Consumer<DashboardApiProvider>(
            builder: (BuildContext context,
                DashboardApiProvider profileProvider, Widget? child) {
              var data = profileProvider.profileDataModel;
              log("profile data consumer $data");
              return profileProvider.profileLoading
                  ? const ProfileLoadingShimmer()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: const BoxDecoration(
                        color: AppColors.profileLabelBg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data != null &&
                                    data.userData != null &&
                                    data.userData!.name != null
                                ? data.userData!.name!
                                : "N/A",
                            style: AppTextStyles.bodyBlack16.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          5.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  data != null &&
                                          data.userData != null &&
                                          data.userData!.companyType != null
                                      ? data.userData!.companyType == 1
                                          ? "Individual"
                                          : "Company"
                                      : "N/A",
                                  style: AppTextStyles.bodyBlack14.copyWith(
                                      color: AppColors.profileLabelTxtColor),
                                ),
                              ),
                              // Text(
                              //   "Edit",
                              //   style: AppTextStyles.bodyBlack14.copyWith(
                              //       color: AppColors.primaryColor,
                              //       fontWeight: FontWeight.w700),
                              // )
                            ],
                          ),
                          5.ph,
                          Text(
                            data != null &&
                                    data.userData != null &&
                                    data.userData!.mobileNumber != null
                                ? data.userData!.mobileNumber!
                                : "N/A",
                            style: AppTextStyles.bodyBlack14.copyWith(
                                color: AppColors.profileLabelTxtColor),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(
                        duration: 500.ms,
                        // end: Offset(dx, dy),
                      );
            },
          ),
          Column(
            children: [
              12.ph,
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressPage(),
                      ),
                    );
                  },
                  child: ProfileLabelWidget(labelName: AppStrings.addressTxt)),
              12.ph,
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderScreen(),
                      ),
                    );
                  },
                  child: ProfileLabelWidget(labelName: AppStrings.orderTxt)),
              12.ph,
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentListScreen(),
                      ),
                    );
                  },
                  child: ProfileLabelWidget(labelName: AppStrings.paymentTxt)),
              12.ph,
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ),
                    );
                  },
                  child:
                      ProfileLabelWidget(labelName: AppStrings.changePassTxt)),
              12.ph,
              ProfileLabelWidget(labelName: AppStrings.helpTxt),
              12.ph,
              ProfileLabelWidget(labelName: AppStrings.supportTxt),
            ],
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(1, 0),
              ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return const LogoutDialog();
              },
            );
          },
          isGradient: false,
          child: Text(
            AppStrings.logoutTxt.toUpperCase(),
            style: AppTextStyles.bodyWhite14,
          ),
        ),
      ).animate().fadeIn(duration: 500.ms),
    );
  }
}
