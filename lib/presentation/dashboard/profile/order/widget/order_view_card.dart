import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/logic/services/formatter.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_details_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';

class OrderViewCard extends StatelessWidget {
  final int index;

  const OrderViewCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var orderData = orderList[index];
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailsScreen.routeName,
            arguments: 5242);
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
                  child: Image.asset(
                    orderData["productImg"]!,
                    height: 50,
                    fit: BoxFit.fill,
                    width: 50,
                  ),
                ),
                8.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order #76r365376",
                        style: AppTextStyles.bodyBlack14
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      5.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "${orderData["productCount"]!} Items",
                              style: AppTextStyles.bodyBlack14.copyWith(),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              orderData["orderDate"]!,
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
                                  int.parse(orderData["productPrice"]!)),
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: getStatusColor(
                                      orderData["productStatus"]!)),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              orderData["productStatus"]!,
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: getStatusColor(
                                      orderData["productStatus"]!)),
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
