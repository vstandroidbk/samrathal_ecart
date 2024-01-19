import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/logic/services/formatter.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_items_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_status_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_details_screen.dart';
import 'package:samrathal_ecart/presentation/verify_otp_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/custom_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../payment/payment_list_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderNumber;

  const OrderDetailsScreen({super.key, required this.orderNumber});

  // static const String routeName = "Order Details Screen";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("${AppStrings.orderTxt} #${widget.orderNumber}")
            .animate()
            .fadeIn(
              duration: 500.ms,
            ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        children: [
          // order status
          const OrderStatusWidget(orderStatus: 2).animate().slide(
                duration: 500.ms,
                begin: const Offset(1, 0),
              ),
          12.ph,
          // total items
          Text(
            AppStrings.orderItemTxt,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w700),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(1, 0),
              ),
          5.ph,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
                        "5 Items",
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ),
                    8.pw,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderItemsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "View All",
                        style: AppTextStyles.bodyBlack14.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
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
                      Formatter.formatPrice(12000),
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
                begin: const Offset(-1, 0),
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColors.profileLabelBg,
            ),
            child: Row(
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
                  height: 60,
                  width: 60,
                )
              ],
            ),
          ).animate().slide(
                duration: 500.ms,
                begin: const Offset(-1, 0),
                // end: Offset(dx, dy),
              ),
          12.ph,
          // receive now and pay now buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerifyOtpScreen(
                            fromScreen: AppStrings.fromOrderScreen),
                      ),
                    );
                  },
                  isGradient: false,
                  backgroundColor: AppColors.redBtnColor,
                  child: Text(
                    AppStrings.receiveNowTxt.toUpperCase(),
                    style: AppTextStyles.bodyWhite14,
                  ),
                ).animate().fadeIn(
                      duration: 500.ms,
                    ),
              ),
              16.pw,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentDetailsScreen(),
                      ),
                    );
                  },
                  isGradient: false,
                  backgroundColor: AppColors.greenBtnColor,
                  child: Text(
                    AppStrings.payNowTxt.toUpperCase(),
                    style: AppTextStyles.bodyWhite14,
                  ),
                ).animate().fadeIn(
                      duration: 500.ms,
                    ),
              ),
            ],
          ),
          16.ph,
        ],
      ),
    );
  }
}
