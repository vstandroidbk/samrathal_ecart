import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../data/model/dashboard/profile/order_details_model.dart';

class OrderStatusWidget extends StatelessWidget {
  final int orderStatus;
  final GetOrderDetailsData orderDetailsData;

  const OrderStatusWidget(
      {Key? key, required this.orderStatus, required this.orderDetailsData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // OrderStatus:
    // 1:Placed
    // 2:Approved
    // 3:Shipped
    // 4:Received
    // 5:Delivered
    // 6:Completed
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
                          : AppColors.unApprovedStatusColor,
                    ),
                  ),
                ],
              ),
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
                    if (orderDetailsData.orderDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderDate!,
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
                            : AppColors.unApprovedStatusColor),
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
                              "Order Approved",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'We has been approved',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (orderDetailsData.orderApproveDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderApproveDate!,
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
                      color: status >= 3
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
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
                      size: 16,
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
                    if (orderDetailsData.orderShippedDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderShippedDate!,
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
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 4
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
                      color: status >= 4
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
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
                              "Received",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Your order has been received successfully.',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (orderDetailsData.orderReceiveDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderReceiveDate!,
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
                      color: status >= 5
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                ],
              ),
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
                              "Delivered",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'We have delivered your order.',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (orderDetailsData.orderDeliverDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderDeliverDate!,
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
                      color: status >= 6
                          ? AppColors.approvedStatusColor
                          : AppColors
                              .unApprovedStatusColor, // Customize the color as needed
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status >= 6
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
                              "Completed",
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Your order has been completed.',
                              style: AppTextStyles.bodyBlack14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (orderDetailsData.orderCompleteDate != null)
                      Expanded(
                        flex: 1,
                        child: Text(
                          orderDetailsData.orderCompleteDate!,
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
