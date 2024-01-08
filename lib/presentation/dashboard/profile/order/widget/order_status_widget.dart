import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/utils/utils.dart';

class OrderStatusWidget extends StatelessWidget {
  final int orderStatus;

  const OrderStatusWidget({Key? key, required this.orderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 0 - Order Placed
    // 1 - Order confirmed
    // 2 - packed
    // 3 - on its way
    // 4 - out for delivery
    // 5 - delivered
    int status = orderStatus;
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 3,
                      color:
                          Colors.transparent, // Customize the color as needed
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 0
                            ? AppColors.approvedStatusColor
                            : AppColors.unApprovedStatusColor),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 0
                          ? AppColors.approvedStatusColor
                          : AppColors.unApprovedStatusColor,
                    ),
                  ),
                ],
              ),
              /* 8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 0
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),*/
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Order Placed",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'We have receive your order',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                        width: 3,
                        color: status >= 1
                            ? AppColors.approvedStatusColor
                            : AppColors.unApprovedStatusColor),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 1
                            ? AppColors.approvedStatusColor
                            : AppColors.unApprovedStatusColor),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 1
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
              /*8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 1
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),*/
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Order Confirmed",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'We has been confirmed',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 2
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 2
                            ? AppColors.approvedStatusColor
                            : AppColors.unApprovedStatusColor),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 2
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
              /*8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 2
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),*/
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Shipped",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'We are shipped your order',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        /*IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 3
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12, // Adjust the height of the timeline indicator
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status >= 3
                          ? AppColors.approvedStatusColor
                          : AppColors.unApprovedStatusColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 3
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
              8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 3
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "On it's way",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Your order is on way',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 4
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12, // Adjust the height of the timeline indicator
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status >= 4
                          ? AppColors.approvedStatusColor
                          : AppColors.unApprovedStatusColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 4
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
              8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 4
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Out for delivery",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Your order is out for delivery',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),*/
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 3,
                      color: status >= 5
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 5
                            ? AppColors.approvedStatusColor
                            : AppColors.unApprovedStatusColor),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 3,
                      color:
                          Colors.transparent, // Customize the color as needed
                    ),
                  ),
                ],
              ),
              /*8.pw,
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status >= 5
                        ? AppColors.approvedStatusColor
                        : AppColors.unApprovedStatusColor),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),*/
              8.pw,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Delivered",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Your order delivered',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "31 Dec 2023",
                        textAlign: TextAlign.end,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
