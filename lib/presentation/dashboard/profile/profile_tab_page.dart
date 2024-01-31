import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/provider/dashboard/dashboard_api_provider.dart';
import '../../../widgets/navigate_anim.dart';
import 'address/address_page.dart';
import 'change_pass/change_password.dart';
import 'order/order_list_screen.dart';
import 'payment/payment_list_screen.dart';
import 'widget/logout_dialog.dart';
import 'widget/profile_label_widget.dart';
import 'widget/profile_loading_shimmer.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    _refreshController.refreshCompleted();
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
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: ListView(
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
                        FadeAnimatingRoute(
                          route: const AddressPage(),
                        ),
                      );
                    },
                    child:
                        ProfileLabelWidget(labelName: AppStrings.addressTxt)),
                12.ph,
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeAnimatingRoute(
                          route: const OrderScreen(),
                        ),
                      );
                    },
                    child: ProfileLabelWidget(labelName: AppStrings.orderTxt)),
                12.ph,
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeAnimatingRoute(
                          route: const PaymentListScreen(),
                        ),
                      );
                    },
                    child:
                        ProfileLabelWidget(labelName: AppStrings.paymentTxt)),
                12.ph,
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeAnimatingRoute(
                          route: const ChangePassword(),
                        ),
                      );
                    },
                    child: ProfileLabelWidget(
                        labelName: AppStrings.changePassTxt)),
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
