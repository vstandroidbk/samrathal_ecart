import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../../core/api_const.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../data/model/dashboard/profile/order_item_details_model.dart';
import '../../../../../logic/services/formatter.dart';

class OrderItemsViewCard extends StatelessWidget {
  final int index;
  final OrderItemData orderItemData;
  final String imgPath;

  const OrderItemsViewCard(
      {super.key,
      required this.index,
      required this.orderItemData,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    var splitList = getSplitList(orderItemData.itemData!);
    var orderPrice = getTotalItemAmount(splitList, orderItemData);
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
                imageUrl: ApiEndPoints.baseUrl + imgPath + orderItemData.image!,
                height: 50,
                fit: BoxFit.fill,
                width: 50,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        child: Text(
                          orderItemData.productName!,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                          child: OrderItemPcView(
                        listSplitData: splitList,
                      ))
                    ],
                  ),
                  5.ph,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          Formatter.formatPrice(orderPrice),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.bodyBlack14.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  RandomItemPcView(
                    listSplitData: splitList,
                    orderItemData: orderItemData,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RandomItemPcView extends StatelessWidget {
  final List<List<num>> listSplitData;
  final OrderItemData orderItemData;

  const RandomItemPcView(
      {super.key, required this.listSplitData, required this.orderItemData});

  @override
  Widget build(BuildContext context) {
    var orderPrice = getRandomItemAmount(listSplitData, orderItemData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: listSplitData.map((size) {
        String pcFromTonKg = getRandomPcsFromTonKg(size);
        return size[4] == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      "",
                      textAlign: TextAlign.start,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      5.ph,
                      Text(
                        "Random settled Qty * $pcFromTonKg",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodyBlack14.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight),
                      ),
                      5.ph,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Settled Amount  ${Formatter.formatPrice(orderPrice)}",
                              textAlign: TextAlign.end,
                              style: AppTextStyles.bodyBlack14.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              )
            : const SizedBox();
      }).toList(),
    );
  }
}

class OrderItemPcView extends StatelessWidget {
  final List<List<num>> listSplitData;

  const OrderItemPcView({super.key, required this.listSplitData});

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
