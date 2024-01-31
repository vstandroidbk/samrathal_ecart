import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/payment_list_loading_shimmer.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/payment_api_provider.dart';
import '../order/widget/no_order_widget.dart';
import 'widget/payment_list_card.dart';

class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  String dropdownValue = "all";

  @override
  void initState() {
    callApi(true);
    super.initState();
  }

  Future<void> callApi(bool isRefresh) async {
    var dataProvider = Provider.of<PaymentApiProvider>(context, listen: false);
    dataProvider.resetOrderPaymentListData();
    dataProvider.setOrderPaymentListNull();
    await dataProvider.getOrderPaymentListData(isRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          // backgroundColor: Colors.white,
          title: Text(AppStrings.paymentListTxt)
              .animate()
              .fadeIn(duration: 500.ms),
          actions: [
            Container(
              height: 35,
              width: 110,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    value: dropdownValue,
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
                      setState(() {
                        dropdownValue = onChangedValue!;
                      });
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
            ).animate().fadeIn(duration: 500.ms),
            12.pw
          ],
        ),
        body: Consumer<PaymentApiProvider>(
          builder: (BuildContext context, PaymentApiProvider paymentProvider,
              Widget? child) {
            return SmartRefresher(
              controller: paymentProvider.orderPaymentListRefreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                paymentProvider.resetOrderPaymentListData();
                await callApi(true);
              },
              onLoading: () async {
                var dataProvider =
                    Provider.of<PaymentApiProvider>(context, listen: false);
                await dataProvider.getOrderPaymentListData(false);
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
                            itemCount:
                                paymentProvider.orderPaymentListObj.length,
                            itemBuilder: (ctx, index) {
                              return PaymentListCard(
                                index: index,
                                paymentList: paymentProvider
                                    .orderPaymentListObj[index],
                              );
                            },
                          ).animate().slideY(
                                duration: 500.ms,
                              ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 5, bottom: 5),
                          child: NoOrderWidget(),
                        ),
            );
          },
        ));
  }
}
