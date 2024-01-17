import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/shop/product_list_model.dart';
import '../product_details_screen.dart';

class ShopProductListCard extends StatelessWidget {
  final ProductListData productListData;
  final String productImgPath;

  const ShopProductListCard(
      {super.key, required this.productListData, required this.productImgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              productId: productListData.id!,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            // width: 120,
            // color: Colors.grey,
            margin: const EdgeInsets.only(right: 0),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Image.asset(
                          //   productList[index]["img"]!,
                          //   fit: BoxFit.fill,
                          //   width: double.infinity,
                          //   height: double.infinity,
                          // ),
                          CachedNetworkImage(
                            imageUrl: ApiEndPoints.baseUrl +
                                productImgPath +
                                productListData.image!,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => const SizedBox(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: -8,
                            right: 1,
                            child: FloatingActionButton(
                              mini: true,
                              heroTag: productListData.image!,
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              child: const Icon(CupertinoIcons.heart),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          productListData.productName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          productListData.sku!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          /*Positioned(
              top: 5,
              left: 3,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 5),
                child: Text(
                  "Most Selling",
                  style: AppTextStyles.bodyWhite10,
                ),
              ),
            )*/
        ],
      ),
    );
  }
}
