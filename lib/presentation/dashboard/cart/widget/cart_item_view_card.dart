import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../shop/product_details_screen.dart';

class CartItemViewCard extends StatelessWidget {
  final int index;

  const CartItemViewCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset(
                productList[index]["img"]!,
                height: 50,
                fit: BoxFit.fill,
                width: 50,
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
                          productList[index]["name"]!,
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
                                  showAlertDialog(context);
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
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return const ProductDetailSDialog();
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
                    child: Column(
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
                    ),
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

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
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
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
