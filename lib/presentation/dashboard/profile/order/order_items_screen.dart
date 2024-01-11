import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_items_view_card.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/services/formatter.dart';

class OrderItemsScreen extends StatefulWidget {
  const OrderItemsScreen({super.key});

  // static const String routeName = "Order Item Screen";

  @override
  State<OrderItemsScreen> createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.orderItemTxt).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          child: Column(
            children: [
              ListView.builder(
                      itemCount: productList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return OrderItemsViewCard(index: index);
                      }).animate().slide(
                    duration: 500.ms,
                    begin: const Offset(1, 0),
                  ),
              // total amount
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                            "Original Price",
                            style: AppTextStyles.bodyBlack16.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        8.pw,
                        Text(
                          Formatter.formatPrice(16000),
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
                            "Round Off Price",
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
              ).animate().slideX(
                    duration: 500.ms,
                  ),
              12.ph,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                            style: AppTextStyles.bodyBlack16.copyWith(
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
              ).animate().slideX(
                    duration: 500.ms,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
