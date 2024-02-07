import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_items_loading_shimmer.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/order_api_provider.dart';
import '../../../../logic/services/formatter.dart';
import 'widget/order_items_view_card.dart';

class OrderItemsScreen extends StatefulWidget {
  final String orderId;

  const OrderItemsScreen({super.key, required this.orderId});

  @override
  State<OrderItemsScreen> createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<OrderApiProvider>(context, listen: false);
    dataProvider.setOrderItemDetailsNull();
    await dataProvider.getOrderItemDetailsData(orderId: widget.orderId);
    _refreshController.refreshCompleted();
  }

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
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<OrderApiProvider>(
          builder: (BuildContext context, OrderApiProvider orderProvider,
              Widget? child) {
            var orderModel = orderProvider.orderItemDetailsModel;
            var orderItemList =
                orderProvider.orderItemDetailsModel?.orderItemData;
            var orderData = orderProvider.orderItemDetailsModel?.getOrderData;
            return orderProvider.orderItemDetailsLoading
                ? const OrderItemLoadingShimmer()
                : orderModel != null &&
                        orderItemList != null &&
                        orderData != null
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              ListView.builder(
                                      itemCount: orderItemList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        return OrderItemsViewCard(
                                          index: index,
                                          orderItemData: orderItemList[index],
                                          imgPath: orderModel.productImagePath!,
                                        );
                                      }).animate().slide(
                                    duration: 500.ms,
                                    begin: const Offset(1, 0),
                                  ),
                              // total amount
                              /*Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.profileLabelBg,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Original Price",
                                            style: AppTextStyles.bodyBlack16
                                                .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Text(
                                          Formatter.formatPrice(16000),
                                          style: AppTextStyles.bodyBlack14
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    5.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Round Off Price",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Text(
                                          Formatter.formatPrice(12000),
                                          style: AppTextStyles.bodyBlack14
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ).animate().slideX(
                                    duration: 500.ms,
                                  ),*/
                              12.ph,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.profileLabelBg,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Total",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Text(
                                          Formatter.formatPrice(num.parse(
                                              orderData.orderAmount!)),
                                          style: AppTextStyles.bodyBlack14
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    5.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Shipping Charge",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Text(
                                          Formatter.formatPrice(num.parse(
                                              orderData.shippingAmount!)),
                                          style: AppTextStyles.bodyBlack14
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    5.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Grand Total",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        8.pw,
                                        Text(
                                          Formatter.formatPrice(num.parse(
                                              orderData.finalOrderAmount!)),
                                          style: AppTextStyles.bodyBlack14
                                              .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    if (orderData.settlementPriceType == "1")
                                      5.ph,
                                    if (orderData.settlementPriceType == "1")
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "SettlementPrice Total",
                                              style: AppTextStyles.bodyBlack14
                                                  .copyWith(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          8.pw,
                                          Text(
                                            Formatter.formatPrice(num.parse(
                                                orderData.settlementPrice!)),
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                      )
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}
