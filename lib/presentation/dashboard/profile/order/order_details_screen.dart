import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_payment_history_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_details_shimmer.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/order_api_provider.dart';
import '../../../../logic/services/formatter.dart';
import '../../../../logic/services/preferences.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/loader_widget.dart';
import '../../../../widgets/navigate_anim.dart';
import 'order_items_screen.dart';
import 'widget/order_status_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderNumber;
  final String orderId;

  const OrderDetailsScreen(
      {super.key, required this.orderNumber, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? mobile;

  @override
  void initState() {
    getMobile();
    callApi();
    super.initState();
  }

  getMobile() async {
    mobile = await SharedPrefProvider.getString(SharedPrefProvider.mobile);
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<OrderApiProvider>(context, listen: false);
    dataProvider.setOrderDetailsNull();
    await dataProvider.getOrderDetailsData(orderId: widget.orderId);
    _refreshController.refreshCompleted();
  }

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
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<OrderApiProvider>(
          builder: (BuildContext context, OrderApiProvider orderProvider,
              Widget? child) {
            var orderModel = orderProvider.orderDetailsModel;
            var orderData =
                orderProvider.orderDetailsModel?.getOrderDetailsData;
            return orderProvider.orderDetailsLoading
                ? const OrderDetailsShimmer()
                : orderModel != null && orderData != null
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // order status
                              OrderStatusWidget(
                                orderStatus: orderData.orderStatus!,
                                orderDetailsData: orderData,
                              ).animate().slide(
                                    duration: 500.ms,
                                    begin: const Offset(1, 0),
                                  ),
                              12.ph,
                              // total items
                              Text(
                                AppStrings.orderItemTxt,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w700),
                              ).animate().slide(
                                    duration: 500.ms,
                                    begin: const Offset(1, 0),
                                  ),
                              5.ph,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 12),
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
                                            orderData.totalItem == 1
                                                ? "${orderData.totalItem} Item"
                                                : "${orderData.totalItem} Items",
                                            style: AppTextStyles.bodyBlack14,
                                          ),
                                        ),
                                        8.pw,
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              FadeAnimatingRoute(
                                                route: OrderItemsScreen(
                                                  orderId: widget.orderId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "View All",
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                              "Settled Price",
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
                              ).animate().slide(
                                    duration: 500.ms,
                                    begin: const Offset(-1, 0),
                                    // end: Offset(dx, dy),
                                  ),
                              12.ph,
                              // address
                              Text(
                                AppStrings.shipAddressTxt,
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w700),
                              ).animate().slide(
                                    duration: 500.ms,
                                    begin: const Offset(-1, 0),
                                    // end: Offset(dx, dy),
                                  ),
                              5.ph,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: AppColors.profileLabelBg,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${orderData.address} ${orderData.landmark} ${orderData.cityName} ${orderData.stateName} (${orderData.pincode})",
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
                              // 12.ph,
                              // // receive now and pay now buttons
                              // Row(
                              //   children: [
                              //     if (orderData.orderStatus == 4)
                              //       Expanded(
                              //         child: CustomButton(
                              //           onPressed: () {
                              //             Navigator.push(
                              //               context,
                              //               FadeAnimatingRoute(
                              //                 route: VerifyOtpScreen(
                              //                     fromScreen: AppStrings
                              //                         .fromOrderScreen),
                              //               ),
                              //             );
                              //           },
                              //           isGradient: false,
                              //           backgroundColor: AppColors.redBtnColor,
                              //           child: Text(
                              //             AppStrings.receiveNowTxt
                              //                 .toUpperCase(),
                              //             style: AppTextStyles.bodyWhite14,
                              //           ),
                              //         ).animate().fadeIn(
                              //               duration: 500.ms,
                              //             ),
                              //       ),
                              //     if (orderData.orderStatus == 4) 16.pw,
                              //     if (orderData.orderStatus != 6)
                              //       Expanded(
                              //         child: CustomButton(
                              //           onPressed: () {
                              //             Navigator.push(
                              //               context,
                              //               FadeAnimatingRoute(
                              //                 route: PaymentMethodScreen(
                              //                   screenType:
                              //                       AppStrings.fromOrderList,
                              //                   orderId: widget.orderId,
                              //                   orderToken:
                              //                       orderData.orderToken,
                              //                 ),
                              //               ),
                              //             );
                              //           },
                              //           isGradient: false,
                              //           backgroundColor:
                              //               AppColors.greenBtnColor,
                              //           child: Text(
                              //             AppStrings.payNowTxt.toUpperCase(),
                              //             style: AppTextStyles.bodyWhite14,
                              //           ),
                              //         ).animate().fadeIn(
                              //               duration: 500.ms,
                              //             ),
                              //       ),
                              //   ],
                              // ),
                              // 16.ph,
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: Consumer<OrderApiProvider>(
        builder: (BuildContext context, OrderApiProvider orderProvider,
            Widget? child) {
          var orderModel = orderProvider.orderDetailsModel;
          var orderData = orderProvider.orderDetailsModel?.getOrderDetailsData;
          return orderProvider.orderDetailsLoading
              ? const SizedBox()
              : orderModel != null && orderData != null
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          if (orderData.orderStatus == 3)
                            Expanded(
                              child: orderProvider.sendOtpLoading
                                  ? const CustomButtonLoader()
                                  : CustomButton(
                                      onPressed: () {
                                        orderProvider.resendOtp(
                                            context: context,
                                            mobile: mobile ?? "",
                                            userType: 1,
                                            orderId: widget.orderId);
                                      },
                                      isGradient: false,
                                      backgroundColor: AppColors.redBtnColor,
                                      child: Text(
                                        AppStrings.receiveNowTxt,
                                        style: AppTextStyles.bodyWhite14,
                                      ),
                                    ).animate().fadeIn(
                                        duration: 500.ms,
                                      ),
                            ),
                          if (orderData.orderStatus == 3) 16.pw,
                          if (orderData.orderToken != null)
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeAnimatingRoute(
                                      route: OrderPaymentHistoryScreen(
                                        orderId: widget.orderId,
                                        orderToken: orderData.orderToken!,
                                      ),
                                    ),
                                  );
                                },
                                isGradient: false,
                                backgroundColor: AppColors.blackColor,
                                child: Text(
                                  AppStrings.paymentHistoryTxt,
                                  style: AppTextStyles.bodyWhite14,
                                ),
                              ).animate().fadeIn(
                                    duration: 500.ms,
                                  ),
                            )
                          /*if (orderData.finalPaymentStatus != null &&
                              orderData.finalPaymentStatus! == false)
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeAnimatingRoute(
                                      route: PaymentMethodScreen(
                                        screenType: AppStrings.fromOrderList,
                                        orderId: widget.orderId,
                                        orderToken: orderData.orderToken,
                                      ),
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
                            ),*/
                        ],
                      ),
                    )
                  : const SizedBox();
        },
      ),
    );
  }
}
