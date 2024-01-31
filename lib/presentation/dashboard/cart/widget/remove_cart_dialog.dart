import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/cart/cart_item_list_model.dart';
import '../../../../logic/provider/dashboard/cart/cart_api_provider.dart';

class RemoveCartDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final CartData cartData;
  final int index;

  const RemoveCartDialog(
      {super.key,
      required this.cartData,
      required this.dialogContext,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
                color: AppColors.primaryColor),
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Alert Dialog",
                  style: AppTextStyles.bodyBlack16
                      .copyWith(color: AppColors.whiteColor),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                25.ph,
                Text(
                  "Would you like to remove this item from cart?",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyBlack16,
                ),
                16.ph,
                Consumer<CartApiProvider>(
                  builder: (BuildContext context, CartApiProvider cartProvider,
                      Widget? child) {
                    return cartProvider.removeCartLoading
                        ? const SpinKitCircle(
                            color: AppColors.primaryColor,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("NO"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<CartApiProvider>(context,
                                          listen: false)
                                      .removeFromCart(
                                          productId: cartData.productId!,
                                          context: context)
                                      .then((value) {
                                    if (context.mounted && value) {
                                      Navigator.pop(dialogContext);
                                    }
                                  });
                                },
                                child: const Text("YES"),
                              )
                            ],
                          );
                  },
                ),
                12.ph,
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms) /*.animate().scaleX(duration: 500.ms),*/
        ],
      ),
    );
  }
}
