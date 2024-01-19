import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/cart/cart_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/cart/update_cart_calculator_provider.dart';
import 'package:samrathal_ecart/presentation/dashboard/cart/widget/remove_cart_dialog.dart';
import 'package:samrathal_ecart/presentation/dashboard/cart/widget/update_cart_dialog.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../../../../core/api_const.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/cart/cart_item_list_model.dart';

class CartItemViewCard extends StatelessWidget {
  final CartData cartData;
  final int index;
  final String imgPath;

  const CartItemViewCard(
      {super.key,
      required this.index,
      required this.cartData,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    var splitList = getSplitList(cartData.itemData!);
    var itemData = cartData.itemData;
    log("cart item data $itemData");
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: ApiEndPoints.baseUrl +
                    imgPath +
                    cartData.productData!.image!,
                height: 50,
                fit: BoxFit.fill,
                width: 50,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            12.pw,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData.productData!.productName!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        3.ph,
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return RemoveCartDialog(
                                        cartData: cartData,
                                        dialogContext: dialogContext,
                                        index: index,
                                      );
                                    },
                                  );
                                  // showAlertDialog(context, cartData, index);
                                },
                                child: Text(
                                  "Remove",
                                  style: AppTextStyles.bodyBlack12.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Provider.of<UpdateCartCalculatorProvider>(
                                          context,
                                          listen: false)
                                      .setDataNull();
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (dialogContext) {
                                      return UpdateCartDialog(
                                        cartData: cartData,
                                        buildContext: context,
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Edit",
                                  style: AppTextStyles.bodyBlack12.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: CartItemPcView(
                    listSplitData: splitList,
                  ) /*Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "5 Kg",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight),
                            ),
                            Text(
                              " * ",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textLight),
                            ),
                            Text(
                              "10 pc",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "10 kg",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight),
                            ),
                            Text(
                              " * ",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight),
                            ),
                            Text(
                              "20 pc",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textLight),
                            ),
                          ],
                        ),
                      ],
                    ),*/
                      ),
                ],
              ),
            ),
            8.pw
          ],
        ),
      ),
    );
  }
}

class CartItemPcView extends StatelessWidget {
  final List<List<int>> listSplitData;

  const CartItemPcView({super.key, required this.listSplitData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: listSplitData.map((size) {
        String kgVal = getKgVal(size);
        String pcFromTonKg = getPcsFromTonKg(size);
        return Text(
          "$kgVal * $pcFromTonKg",
          textAlign: TextAlign.start,
          style: AppTextStyles.bodyBlack14.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textLight),
        );
      }).toList(),
    );
  }
}

showAlertDialog(BuildContext dialogContext, CartData cartData, int index) {
// set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(dialogContext);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Provider.of<CartApiProvider>(dialogContext, listen: false)
          .removeFromCart(
              productId: cartData.productId!, context: dialogContext)
          .then((value) {
        if (value) {
          Navigator.pop(dialogContext);
        }
      });
      Navigator.pop(dialogContext);
    },
  );

// set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("AlertDialog"),
    content: const Text("Would you like to remove this item from cart?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

// show the dialog
  showDialog(
    context: dialogContext,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
