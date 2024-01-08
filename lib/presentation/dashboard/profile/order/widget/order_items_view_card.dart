import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../logic/services/formatter.dart';

class OrderItemsViewCard extends StatelessWidget {
  final int index;

  const OrderItemsViewCard({super.key, required this.index});

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
            8.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          productList[index]["name"]!,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "2",
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
                              "5",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textLight),
                            ),
                            Text(
                              "Kg",
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textLight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          Formatter.formatPrice(1200),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.bodyBlack14.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
