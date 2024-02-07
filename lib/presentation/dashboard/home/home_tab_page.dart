import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/provider/dashboard/dashboard_api_provider.dart';
import '../../../widgets/navigate_anim.dart';
import '../dashboard_screen.dart';
import 'widgets/dashboard_loading_shimmer.dart';
import 'widgets/home_label_widget.dart';
import 'widgets/home_offers_list_view_card.dart';
import 'widgets/product_list_card.dart';
import 'widgets/slider_widget.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider =
        Provider.of<DashboardApiProvider>(context, listen: false);
    dataProvider.setDashboardDataNull();
    dataProvider.setCartCountDataNull();
    await dataProvider.getDashboardDataApi();
    await dataProvider.getCartCount();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        titleSpacing: 12,
        title: Row(
          children: [
            Text(AppStrings.appName).animate().fadeIn(duration: 500.ms),
            16.pw,
          ],
        ),
        actions: [
          Consumer<DashboardApiProvider>(
            builder: (BuildContext context,
                DashboardApiProvider dashboardProvider, Widget? child) {
              var dashboardModel = dashboardProvider.dashboardDataModel;
              var orderCount =
                  dashboardProvider.dashboardDataModel?.totalOrderCount;
              return dashboardModel != null && orderCount != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Text(
                        "Total orders $orderCount",
                        style: AppTextStyles.bodyWhite14,
                      ).animate().fadeIn(duration: 500.ms),
                    )
                  : const SizedBox();
            },
          ),
          8.pw,
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  FadeAnimatingRoute(
                    route: const DashboardScreen(selectedTab: 2),
                  ),
                  (route) => false);
            },
            child: Consumer<DashboardApiProvider>(
              builder: (BuildContext context,
                  DashboardApiProvider dashboardProvider, Widget? child) {
                var cartCountData = dashboardProvider.cartCountModel?.cartCount;
                var cartCountModel = dashboardProvider.cartCountModel;
                return dashboardProvider.cartCountLoading
                    ? Shimmer.fromColors(
                        baseColor: AppColors.grey300,
                        highlightColor: AppColors.grey100,
                        child: Badge(
                          label: Text(
                            "__",
                            style: AppTextStyles.bodyBlack12,
                          ),
                          backgroundColor: Colors.white,
                          child: const Icon(
                            CupertinoIcons.cart,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : cartCountModel != null && cartCountData != null
                        ? Badge(
                            label: Text(
                              cartCountData.toString(),
                              style: AppTextStyles.bodyBlack12,
                            ),
                            backgroundColor: Colors.white,
                            child: const Icon(
                              CupertinoIcons.cart,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox();
              },
            ),
          ).animate().fadeIn(duration: 500.ms),
          16.pw,
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Consumer<DashboardApiProvider>(
            builder: (BuildContext context,
                DashboardApiProvider dashboardProvider, Widget? child) {
              var dashboardModel = dashboardProvider.dashboardDataModel;
              var sliderData = dashboardProvider.dashboardDataModel?.sliderData;
              var offerData = dashboardProvider.dashboardDataModel?.offerData;
              var productData =
                  dashboardProvider.dashboardDataModel?.productData;
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () {
                  callApi();
                },
                child: dashboardProvider.dashboardLoading
                    ? const DashboardLoadingShimmer()
                    : ListView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          if (dashboardModel != null &&
                              sliderData != null &&
                              sliderData.isNotEmpty)
                            SliderWidget(
                              sliderData: sliderData,
                              sliderImgPath: dashboardModel.sliderImagePath,
                            ).animate().slide(
                                  duration: 500.ms,
                                  begin: const Offset(1, 0),
                                ),
                          12.ph,
                          if (dashboardModel != null &&
                              offerData != null &&
                              offerData.isNotEmpty &&
                              dashboardModel.offerImagePath != null)
                            HomeLabelWidget(labelName: AppStrings.offersTxt)
                                .animate()
                                .slide(
                                  duration: 500.ms,
                                  begin: const Offset(-1, 0),
                                ),
                          if (dashboardModel != null &&
                              offerData != null &&
                              offerData.isNotEmpty &&
                              dashboardModel.offerImagePath != null)
                            5.ph,
                          if (dashboardModel != null &&
                              offerData != null &&
                              offerData.isNotEmpty &&
                              dashboardModel.offerImagePath != null)
                            SizedBox(
                              height: 150,
                              width: mq.width * 0.8,
                              child: ListView.builder(
                                itemCount: offerData.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: HomeOfferListViewCard(
                                      offerData: offerData[index],
                                      offerImgPath:
                                          dashboardModel.offerImagePath!,
                                    ),
                                  );
                                },
                              ),
                            ).animate().slide(
                                  duration: 500.ms,
                                  begin: const Offset(-1, 0),
                                ),
                          12.ph,
                          HomeLabelWidget(labelName: AppStrings.productsTxt)
                              .animate()
                              .slide(
                                duration: 500.ms,
                                begin: const Offset(1, 0),
                              ),
                          5.ph,
                          if (dashboardModel != null &&
                              productData != null &&
                              dashboardModel.productImagePath != null &&
                              productData.isNotEmpty)
                            SizedBox(
                              height: 220,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: productData.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductListCard(
                                    productImgPath:
                                        dashboardModel.productImagePath!,
                                    productData: productData[index],
                                  );
                                },
                              ),
                            ).animate().slide(
                                  duration: 500.ms,
                                  begin: const Offset(1, 0),
                                ),
                        ],
                      ),
              );
            },
          )),
    );
  }
}
