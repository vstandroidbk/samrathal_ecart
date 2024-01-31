import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../core/api_const.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/provider/dashboard/shop/add_cart_calculator_provider.dart';
import '../../../logic/provider/dashboard/shop/shop_api_provider.dart';
import '../../../logic/services/formatter.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_paragraph.dart';
import '../../../widgets/navigate_anim.dart';
import '../../../widgets/photo_view_screen.dart';
import '../dashboard_screen.dart';
import 'widget/add_to_cart_dialog.dart';
import 'widget/product_details_shimmer.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<SizeInfo> sizes = [
    SizeInfo(id: 1, size: '5 kg'),
    SizeInfo(id: 2, size: '10 kg'),
    SizeInfo(id: 3, size: '25 kg'),
    SizeInfo(id: 5, size: 'Random'),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<ShopApiProvider>(context, listen: false);
    dataProvider.setProductDetailsDataNull();
    await dataProvider.getProductDetailsApi(productId: widget.productId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.productDetailsTxt),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  FadeAnimatingRoute(
                    route: const DashboardScreen(selectedTab: 2),
                  ),
                  (route) => false);
            },
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
          ),
          16.pw,
        ],
      ),
      body: Consumer<ShopApiProvider>(
        builder: (BuildContext context, ShopApiProvider shopProvider,
            Widget? child) {
          var productDetailsModel = shopProvider.productDetailsModel;
          var productDetailsData =
              shopProvider.productDetailsModel?.productDetails;
          var productImgPath =
              shopProvider.productDetailsModel?.productImagePath;
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              callApi();
            },
            child: shopProvider.productDetailsLoading
                ? const ProductDetailsShimmer()
                : SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const ProductSliderWidget(),
                          if (productDetailsModel != null &&
                              productDetailsData != null &&
                              productImgPath != null)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  FadeAnimatingRoute(
                                    route: PhotoViewScreen(
                                      imgUrl: ApiEndPoints.baseUrl +
                                          productImgPath +
                                          productDetailsData.image!,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    // width: size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: ApiEndPoints.baseUrl +
                                              productImgPath +
                                              productDetailsData.image!,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 150,
                                          placeholder: (context, url) =>
                                              const SizedBox(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          12.ph,
                          // product name and sku
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productDetailsData.productName != null
                                          ? productDetailsData.productName!
                                          : "N/A",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    3.ph,
                                    Text(
                                      productDetailsData.sku != null
                                          ? productDetailsData.sku!
                                          : "N/A",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          color: AppColors.primaryColor),
                                    ),
                                    3.ph,
                                    Text(
                                      productDetailsData.retailTonAmount != null
                                          ? "Price : ${Formatter.formatPrice(int.parse(productDetailsData.retailTonAmount!))} / Ton"
                                          : "N/A",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    3.ph,
                                    Text(
                                      productDetailsData.wholeSaleTonAmount !=
                                              null
                                          ? "Whole Sale Price : ${Formatter.formatPrice(int.parse(productDetailsData.wholeSaleTonAmount!))} / Ton"
                                          : "N/A",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                                const Icon(CupertinoIcons.heart)
                              ],
                            ),
                          // packaging size
                          12.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.packingSizeTxt,
                                    style: AppTextStyles.bodyBlack14
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                // if (productDetailsModel != null &&
                                //     productDetailsData != null)
                                //   Expanded(
                                //     child: Text(
                                //       productDetailsData.wholeSaleTonMinQty !=
                                //               null
                                //           ? "MOQ : ${productDetailsData.wholeSaleTonMinQty} Ton"
                                //           : "N/A",
                                //       textAlign: TextAlign.right,
                                //       style: AppTextStyles.bodyBlack14
                                //           .copyWith(fontWeight: FontWeight.w500),
                                //     ),
                                //   ),
                              ],
                            ),
                          8.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            Wrap(
                              spacing: 16.0,
                              runSpacing: 8.0,
                              children: sizes
                                  .map((size) => Container(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 5,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 1)),
                                        child: Text(
                                          size.size,
                                          style: AppTextStyles.bodyBlack14,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          12.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            Text(
                              AppStrings.descriptionTxt,
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          5.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            CustomParagraph(
                                description:
                                    productDetailsData.shortDescription != null
                                        ? productDetailsData.shortDescription!
                                        : "N/A"),
                          12.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            Text(
                              AppStrings.productDetailsTxt,
                              style: AppTextStyles.bodyBlack14
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          5.ph,
                          if (productDetailsModel != null &&
                              productDetailsData != null)
                            HtmlWidget(
                              productDetailsData.longDescription != null
                                  ? productDetailsData.longDescription!
                                  : "N/A",
                              textStyle: AppTextStyles.bodyBlack14
                                  .copyWith(color: AppColors.descColor),
                              // onTapUrl: (url) => openUrl(url),
                            ),
                          /*const ProductDetailsLabel(
                            title: "Application Area",
                            value: " For Construction",
                          ),
                          3.ph,
                          const ProductDetailsLabel(
                            title: "Wire Material",
                            value: "Mild Steel",
                          ),
                          3.ph,
                          const ProductDetailsLabel(
                            title: "Conductor Type",
                            value: "Solid",
                          ),
                          3.ph,
                          const ProductDetailsLabel(
                            title: "Uses/Application",
                            value: "For Agriculture",
                          ),*/
                          20.ph,
                        ],
                      ).animate().slideY(
                            duration: 500.ms,
                          ),
                    ),
                  ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Consumer<ShopApiProvider>(
          builder: (BuildContext context, ShopApiProvider shopProvider,
              Widget? child) {
            var productDetailsModel = shopProvider.productDetailsModel;
            var productDetailsData =
                shopProvider.productDetailsModel?.productDetails;
            return shopProvider.productDetailsLoading
                ? const SizedBox()
                : productDetailsModel != null && productDetailsData != null
                    ? productDetailsModel.cartStatus == 0
                        ? CustomButton(
                            onPressed: () {
                              Provider.of<AddCartCalculatorProvider>(context,
                                      listen: false)
                                  .setDataNull();
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (dialogContext) {
                                  return AddToCartDialog(
                                    productDetails: productDetailsData,
                                    buildContext: context,
                                  );
                                },
                              );
                            },
                            isGradient: false,
                            child: Text(
                              AppStrings.addToCartTxt.toUpperCase(),
                              style: AppTextStyles.bodyWhite14,
                            ),
                          )
                        : CustomButton(
                            onPressed: () {},
                            backgroundColor: AppColors.grey300,
                            isGradient: false,
                            child: Text(
                              AppStrings.addedToCartTxt.toUpperCase(),
                              style: AppTextStyles.bodyWhite14
                                  .copyWith(color: Colors.grey),
                            ),
                          )
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}

class ProductDetailsLabel extends StatelessWidget {
  final String title;
  final String value;

  const ProductDetailsLabel(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyBlack14,
          ),
        ),
        const Text(":"),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class SizeInfo {
  final int id;
  final String size;

  SizeInfo({required this.id, required this.size});
}
