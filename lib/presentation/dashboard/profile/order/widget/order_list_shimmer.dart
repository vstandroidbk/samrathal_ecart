import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../logic/services/formatter.dart';

class OrderListShimmer extends StatelessWidget {
  const OrderListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
        child: ListView.builder(
            itemCount: 15,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          height: 50,
                          color: Colors.grey,
                          width: 50,
                        ),
                      ),
                      8.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.grey,
                              child: Text(
                                "Order #76r365376",
                                style: AppTextStyles.bodyBlack14
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            5.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "5 Items",
                                      style:
                                          AppTextStyles.bodyBlack14.copyWith(),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "12 jan 2024",
                                      style:
                                          AppTextStyles.bodyBlack14.copyWith(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            5.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Text(
                                      Formatter.formatPrice(int.parse("5000")),
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    color: Colors.grey,
                                    child: Text(
                                      "Pending",
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      5.pw,
                      Container(
                        color: Colors.grey,
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
