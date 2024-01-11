import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/presentation/dashboard/cart/select_address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/cart/widget/cart_item_view_card.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_success_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_details_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_images.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/services/formatter.dart';
import '../../../widgets/custom_button.dart';

class CartTabPage extends StatefulWidget {
  const CartTabPage({super.key});

  @override
  State<CartTabPage> createState() => _CartTabPageState();
}

class _CartTabPageState extends State<CartTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Text(AppStrings.cartTabTxt).animate().fadeIn(duration: 500.ms),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          12.ph,
          Text(
            AppStrings.cartItemsTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w700),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(-1, 0),
                // end: Offset(dx, dy),
              ),
          ListView.builder(
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return CartItemViewCard(index: index);
            },
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(-1, 0),
              ),
          5.ph,
          // total amount
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColors.profileLabelBg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Total",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    8.pw,
                    Text(
                      Formatter.formatPrice(12000),
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                5.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Shipping Charge",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    8.pw,
                    Text(
                      Formatter.formatPrice(500),
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                5.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Discount",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    8.pw,
                    Text(
                      Formatter.formatPrice(1000),
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                5.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Grand Total",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    8.pw,
                    Text(
                      Formatter.formatPrice(11500),
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(1, 0),
                // end: Offset(dx, dy),
              ),
          12.ph,
          Text(
            "Estimate Distance 10 km",
            style: AppTextStyles.bodyBlack14,
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(1, 0),
                // end: Offset(dx, dy),
              ),
          12.ph,
          // address
          Text(
            AppStrings.shipAddressTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w700),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(-1, 0),
                // end: Offset(dx, dy),
              ),
          5.ph,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: AppColors.profileLabelBg,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Deliver To:",
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectAddressPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          side: const BorderSide(
                            width: 1.0,
                            color: AppColors.primaryColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text(
                          "Change",
                          style: AppTextStyles.bodyBlack14
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
                8.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "A-1, Narayanpuri,kalwad road,  jhotwara Jaipur",
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ),
                    8.pw,
                    Image.asset(
                      AppImages.locationImg,
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ],
            ),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(-1, 0),
                // end: Offset(dx, dy),
              ),
          12.ph,
          // receive now and pay now buttons
          CustomButton(
            height: 40,
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return const CheckoutDialog();
                },
              );
            },
            isGradient: false,
            backgroundColor: AppColors.redBtnColor,
            child: Text(
              AppStrings.checkoutTxt.toUpperCase(),
              style: AppTextStyles.bodyWhite14,
            ),
          ).animate().fadeIn(duration: 500.ms),
          16.ph,
        ],
      ),
    );
  }
}

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  List<String> paymentOption = ["Cash on delivery", "Offline"];

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: 278,
      // width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Form(
            // key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // account details
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentOption.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                log("selected account = $selectedIndex");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: index == selectedIndex
                                          ? BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              color: Colors.red,
                                              shape: BoxShape.circle)
                                          : BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(paymentOption[index])
                                    // Downward arrow)
                                  ],
                                ),
                              ),
                            ),
                          ));
                    }),
                CustomButton(
                  onPressed: () {
                    if (selectedIndex == -1) {
                      Utils.showToast("Please select a payment option");
                      return;
                    }
                    if (selectedIndex == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderSuccessScreen(),
                        ),
                      );
                    } else if (selectedIndex == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentDetailsScreen(),
                        ),
                      );
                    }
                  },
                  isGradient: false,
                  child: Text(
                    "Proceed".toUpperCase(),
                    style: AppTextStyles.bodyWhite14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
