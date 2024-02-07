import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/order_api_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/navigate_anim.dart';
import '../payment/payment_method_screen.dart';
import '../payment/widget/payment_list_card.dart';
import '../payment/widget/payment_list_loading_shimmer.dart';

class OrderPaymentHistoryScreen extends StatefulWidget {
  final String orderId;
  final String orderToken;

  const OrderPaymentHistoryScreen(
      {super.key, required this.orderId, required this.orderToken});

  @override
  State<OrderPaymentHistoryScreen> createState() =>
      _OrderPaymentHistoryScreenState();
}

class _OrderPaymentHistoryScreenState extends State<OrderPaymentHistoryScreen> {
  ValueNotifier<String?> paymentStatus = ValueNotifier("ALL");

  @override
  void initState() {
    callApi(true);
    super.initState();
  }

  Future<void> callApi(bool isRefresh) async {
    var dataProvider = Provider.of<OrderApiProvider>(context, listen: false);
    dataProvider.resetOrderPaymentListData();
    dataProvider.setOrderPaymentListNull();
    await dataProvider.getOrderPaymentListData(
        isRefresh: isRefresh,
        paymentStatus: paymentStatus.value!,
        orderId: widget.orderId);
    dataProvider.orderPaymentListRefreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // backgroundColor: Colors.white,
        title:
            Text(AppStrings.paymentListTxt).animate().fadeIn(duration: 500.ms),
        actions: [
          ValueListenableBuilder(
            valueListenable: paymentStatus,
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                height: 35,
                width: 110,
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      value: paymentStatus.value,
                      isExpanded: true,
                      isDense: true,
                      style: AppTextStyles.bodyBlack14,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Image.asset(
                          AppImages.filterImg,
                          height: 18,
                          width: 18,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (onChangedValue) async {
                        paymentStatus.value = onChangedValue;
                        await callApi(true);
                      },
                      selectedItemBuilder: (BuildContext context) {
                        return paymentStatusList.map((value) {
                          return Center(
                            child: Text(
                              value["status"],
                              style: AppTextStyles.bodyWhite14,
                            ),
                          );
                        }).toList();
                      },
                      items: paymentStatusList.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item["id"].toString(),
                            child: Text(
                              item["status"].toString(),
                              style: AppTextStyles.bodyBlack14,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms);
            },
          ),
          12.pw
        ],
      ),
      body: Consumer<OrderApiProvider>(
        builder: (BuildContext context, OrderApiProvider paymentProvider,
            Widget? child) {
          return SmartRefresher(
            controller: paymentProvider.orderPaymentListRefreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              // paymentProvider.resetOrderPaymentListData();
              await callApi(true);
            },
            onLoading: () async {
              var dataProvider =
                  Provider.of<OrderApiProvider>(context, listen: false);
              await dataProvider.getOrderPaymentListData(
                  isRefresh: false,
                  paymentStatus: paymentStatus.value!,
                  orderId: widget.orderId);
            },
            child: paymentProvider.orderPaymentListLoading
                ? const OrderPaymentListShimmer()
                : paymentProvider.orderPaymentListObj.isNotEmpty
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          itemCount: paymentProvider.orderPaymentListObj.length,
                          itemBuilder: (ctx, index) {
                            return PaymentListCard(
                              index: index,
                              paymentList:
                                  paymentProvider.orderPaymentListObj[index],
                            );
                          },
                        ).animate().slideY(
                              duration: 500.ms,
                            ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.noOrderImg),
                            5.ph,
                            Text(
                              AppStrings.noOrderTxt,
                              style: AppTextStyles.bodyBlack18
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
      bottomNavigationBar: Consumer<OrderApiProvider>(
        builder: (BuildContext context, OrderApiProvider orderProvider,
            Widget? child) {
          var orderModel = orderProvider.orderPaymentListModel;
          return orderProvider.orderDetailsLoading
              ? const SizedBox()
              : orderModel != null &&
                      orderModel.finalPaymentStatus != null &&
                      orderModel.finalPaymentStatus == false
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeAnimatingRoute(
                              route: PaymentMethodScreen(
                                screenType: AppStrings.fromOrderList,
                                orderId: widget.orderId,
                                orderToken: widget.orderToken,
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
                    )
                  : const SizedBox();
        },
      ),
    );
  }
}
