import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_success_screen.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:samrathal_ecart/widgets/loader_widget.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_images.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/provider/dashboard/cart/cart_api_provider.dart';
import '../../../logic/services/formatter.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/navigate_anim.dart';
import '../../../widgets/no_data_found.dart';
import '../profile/payment/payment_method_screen.dart';
import 'select_address_page.dart';
import 'widget/cart_item_view_card.dart';
import 'widget/cart_loading_shimmer.dart';

class CartTabPage extends StatefulWidget {
  const CartTabPage({super.key});

  @override
  State<CartTabPage> createState() => _CartTabPageState();
}

class _CartTabPageState extends State<CartTabPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<CartApiProvider>(context, listen: false);
    dataProvider.setCartListDataNull();
    await dataProvider.getCartListApi();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Text(AppStrings.cartTabTxt).animate().fadeIn(duration: 500.ms),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<CartApiProvider>(
          builder: (BuildContext context, CartApiProvider cartProvider,
              Widget? child) {
            var cartListModel = cartProvider.cartListModel;
            var cartData = cartProvider.cartListModel?.cartData;
            var addressData = cartProvider.cartListModel?.addressData;
            var productImgPath = cartProvider.cartListModel?.productImagePath;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: cartProvider.cartListLoading
                  ? const CartLoadingShimmer()
                  : cartData != null
                      ? cartData.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  12.ph,
                                  Text(
                                    AppStrings.cartItemsTxt,
                                    style: AppTextStyles.bodyBlack14
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ).animate().slide(
                                        duration: 500.ms,
                                        begin: const Offset(-1, 0),
                                        // end: Offset(dx, dy),
                                      ),
                                  if (cartListModel != null &&
                                      productImgPath != null)
                                    ListView.builder(
                                      itemCount: cartData.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, index) {
                                        return CartItemViewCard(
                                          index: index,
                                          cartData: cartData[index],
                                          imgPath: productImgPath,
                                        );
                                      },
                                    ).animate().slide(
                                          duration: 500.ms,
                                          begin: const Offset(-1, 0),
                                        ),
                                  5.ph,
                                  // total amount
                                  if (cartListModel != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 12),
                                      decoration: const BoxDecoration(
                                        color: AppColors.profileLabelBg,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Total",
                                                  style: AppTextStyles
                                                      .bodyBlack14
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              8.pw,
                                              Text(
                                                Formatter.formatPrice(
                                                    getCartTotalAmount(
                                                        cartData)),
                                                style: AppTextStyles.bodyBlack14
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          if (cartListModel.shippingAmount !=
                                              null)
                                            5.ph,
                                          if (cartListModel.shippingAmount !=
                                              null)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Shipping Charge",
                                                    style: AppTextStyles
                                                        .bodyBlack14
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                                8.pw,
                                                Text(
                                                  Formatter.formatPrice(
                                                      cartListModel
                                                          .shippingAmount!),
                                                  style: AppTextStyles
                                                      .bodyBlack14
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                                  style: AppTextStyles
                                                      .bodyBlack14
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                              8.pw,
                                              Text(
                                                cartListModel.shippingAmount !=
                                                        null
                                                    ? Formatter.formatPrice(
                                                        getCartTotalAmount(
                                                                cartData) +
                                                            cartListModel
                                                                .shippingAmount!)
                                                    : Formatter.formatPrice(
                                                        getCartTotalAmount(
                                                                cartData) +
                                                            0),
                                                style: AppTextStyles.bodyBlack14
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ).animate().slide(
                                          duration: 500.ms,
                                          begin: const Offset(1, 0),
                                          // end: Offset(dx, dy),
                                        ),
                                  12.ph,
                                  if (cartListModel != null &&
                                      cartListModel.distance != null)
                                    Text(
                                      "Estimate Distance ${cartListModel.distance} km",
                                      style: AppTextStyles.bodyBlack14,
                                    ).animate().slide(
                                          duration: 500.ms,
                                          begin: const Offset(1, 0),
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
                                        vertical: 12, horizontal: 16),
                                    decoration: const BoxDecoration(
                                      color: AppColors.profileLabelBg,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Deliver To:",
                                                style: AppTextStyles.bodyBlack14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                            if (addressData != null)
                                              SizedBox(
                                                height: 30,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      FadeAnimatingRoute(
                                                        route:
                                                            const SelectAddressPage(),
                                                      ),
                                                    ).then((value) {
                                                      callApi();
                                                    });
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                    ),
                                                    side: const BorderSide(
                                                      width: 1.0,
                                                      color: AppColors
                                                          .primaryColor,
                                                      style: BorderStyle.solid,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Change",
                                                    style: AppTextStyles
                                                        .bodyBlack14
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                        8.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                addressData != null
                                                    ? "${addressData.address} ${addressData.landmark} ${addressData.districtData?.districtName} ${addressData.stateData?.stateName} (${addressData.zipCode})"
                                                    : "N/A",
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            ),
                                            8.pw,
                                            Image.asset(
                                              AppImages.locationImg,
                                              height: 40,
                                              width: 40,
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
                                  // receive now and pay now buttons
                                  CustomButton(
                                    height: 40,
                                    onPressed: () {
                                      if (addressData == null) {
                                        Utils.showToast(
                                            "Please select your primary address");
                                        Navigator.push(
                                          context,
                                          FadeAnimatingRoute(
                                            route: const SelectAddressPage(),
                                          ),
                                        ).then((value) {
                                          callApi();
                                        });
                                        return;
                                      }
                                      cartProvider.setOrderPlaceLoaderFalse();
                                      showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return CheckoutDialog(
                                            addressId: addressData.id!,
                                            shippingCharge:
                                                cartListModel?.shippingAmount,
                                            distance: cartListModel?.distance,
                                          );
                                        },
                                      );
                                    },
                                    isGradient: false,
                                    backgroundColor: AppColors.redBtnColor,
                                    child: Text(
                                      AppStrings.checkoutTxt.toUpperCase(),
                                      style: AppTextStyles.bodyWhite14,
                                    ),
                                  ).animate().fadeIn(duration: 500.ms),
                                  16.ph,
                                ],
                              ),
                            )
                          : const NoDataFound()
                      : const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}

class CheckoutDialog extends StatefulWidget {
  final String addressId;
  final num? distance;
  final num? shippingCharge;

  const CheckoutDialog(
      {super.key, required this.addressId, this.shippingCharge, this.distance});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  List<String> paymentOption = ["Cash on delivery", "Offline"];

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: 278,
      // width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Form(
            // key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // account details
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentOption.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                log("selected account = $selectedIndex");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: index == selectedIndex
                                          ? BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              color: Colors.red,
                                              shape: BoxShape.circle)
                                          : BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(paymentOption[index])
                                    // Downward arrow)
                                  ],
                                ),
                              ),
                            ),
                          ));
                    }),
                Consumer<CartApiProvider>(
                  builder: (BuildContext context, CartApiProvider cartProvider,
                      Widget? child) {
                    return cartProvider.orderPlaceLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () async {
                              if (selectedIndex == -1) {
                                Utils.showToast(
                                    "Please select a payment option");
                                return;
                              }
                              if (selectedIndex == 0) {
                                var bool = await cartProvider.orderPlaceApi(
                                    addressId: widget.addressId,
                                    context: context,
                                    distance: widget.distance,
                                    shippingCharge: widget.shippingCharge);
                                if (context.mounted && bool) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    FadeAnimatingRoute(
                                      route: const OrderSuccessScreen(),
                                    ),
                                  );
                                }
                                // Navigator.push(
                                //   context,
                                //   FadeAnimatingRoute(
                                //     route: const OrderSuccessScreen(),
                                //   ),
                                // );
                              } else if (selectedIndex == 1) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  FadeAnimatingRoute(
                                    route: PaymentMethodScreen(
                                      screenType: AppStrings.fromCart,
                                      addressId: widget.addressId,
                                      distance: widget.distance,
                                      shippingCharge: widget.shippingCharge,
                                    ),
                                  ),
                                );
                              }
                            },
                            isGradient: false,
                            child: Text(
                              "Proceed".toUpperCase(),
                              style: AppTextStyles.bodyWhite14,
                            ),
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
