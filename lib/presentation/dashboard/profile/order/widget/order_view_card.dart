import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/data/model/dashboard/profile/order_list_model.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../../core/api_const.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../logic/services/formatter.dart';
import '../../../../../widgets/navigate_anim.dart';
import '../order_details_screen.dart';

class OrderViewCard extends StatelessWidget {
  final GetOrderData getOrderData;
  final int index;
  final String imgPath;

  const OrderViewCard(
      {super.key,
      required this.index,
      required this.getOrderData,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          FadeAnimatingRoute(
            route: OrderDetailsScreen(
                orderId: getOrderData.id!, orderNumber: getOrderData.orderId!),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Card(
          // color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: ApiEndPoints.baseUrl +
                        imgPath +
                        getOrderData.productImage!,
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                8.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order #${getOrderData.orderId}",
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${getOrderData.totalItem} Items",
                              style: AppTextStyles.bodyBlack14.copyWith(),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              getOrderData.orderDate!,
                              style: AppTextStyles.bodyBlack14.copyWith(),
                            ),
                          )
                        ],
                      ),
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              Formatter.formatPrice(
                                  num.parse(getOrderData.finalOrderAmount!)),
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          Flexible(
                              child: Text(
                            getStatus(getOrderData.orderStatus!),
                            style: AppTextStyles.bodyBlack14.copyWith(
                              fontWeight: FontWeight.w700,
                              color: getStatusColor(getOrderData.orderStatus!),
                            ),
                          ))
                        ],
                      ),
                      if (getOrderData.settlementPriceType == "1") 5.ph,
                      if (getOrderData.settlementPriceType == "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Settled Price  ${Formatter.formatPrice(num.parse(getOrderData.settlementPrice!))}",
                                style: AppTextStyles.bodyBlack14.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                5.pw,
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
