import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/order_api_provider.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/no_order_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_list_shimmer.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import 'widget/order_view_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String dropdownValue = "all";

  @override
  void initState() {
    callApi(true);
    super.initState();
  }

  Future<void> callApi(bool isRefresh) async {
    var dataProvider = Provider.of<OrderApiProvider>(context, listen: false);
    dataProvider.resetOrderHistoryListData();
    dataProvider.setOrderListNull();
    await dataProvider.getOrderListData(isRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          title: Text(AppStrings.orderTxt).animate().fadeIn(
                duration: 500.ms,
              ),
          actions: [
            Container(
              height: 35,
              width: 150,
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
                      padding: const EdgeInsets.only(left: 8),
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
                      return dropDownList.map((value) {
                        return Center(
                          child: Text(
                            value["status"],
                            style: AppTextStyles.bodyWhite14,
                          ),
                        );
                      }).toList();
                    },
                    items: dropDownList.map(
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
            ).animate().fadeIn(
                  duration: 500.ms,
                ),
            12.pw
          ],
        ),
        body: Consumer<OrderApiProvider>(
          builder: (BuildContext context, productListProvider, Widget? child) {
            var imgPath = productListProvider.orderListModel?.productImagePath;
            return SmartRefresher(
              controller: productListProvider.orderHistoryListRefreshController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () async {
                productListProvider.resetOrderHistoryListData();
                await callApi(true);
              },
              onLoading: () async {
                var dataProvider =
                    Provider.of<OrderApiProvider>(context, listen: false);
                await dataProvider.getOrderListData(false);
              },
              child: productListProvider.orderListLoading
                  ? const OrderListShimmer()
                  : productListProvider.orderHistoryListObj.isNotEmpty
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 5, bottom: 5),
                            child: ListView.builder(
                                    itemCount: productListProvider
                                        .orderHistoryListObj.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      return OrderViewCard(
                                        index: index,
                                        getOrderData: productListProvider
                                            .orderHistoryListObj[index],
                                        imgPath: imgPath!,
                                      );
                                    }).animate().slideY(
                                  duration: 500.ms,
                                ),
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
