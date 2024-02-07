import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/api_const.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/wishlist/wishlist_model.dart';
import '../../../../logic/provider/dashboard/wishlist/wishlist_api_provider.dart';
import '../../../../widgets/navigate_anim.dart';
import '../../shop/product_details_screen.dart';

class WishlistProductListCard extends StatelessWidget {
  final WishListData wishListData;
  final String productImgPath;

  const WishlistProductListCard(
      {super.key, required this.wishListData, required this.productImgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          FadeAnimatingRoute(
            route: ProductDetailsScreen(
              productId: wishListData.productId!,
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
                          CachedNetworkImage(
                            imageUrl: ApiEndPoints.baseUrl +
                                productImgPath +
                                wishListData.image!,
                            fit: BoxFit.fill,
                            height: double.infinity,
                            width: double.infinity,
                            placeholder: (context, url) => const SizedBox(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Consumer<WishlistApiProvider>(
                            builder: (BuildContext context,
                                WishlistApiProvider wishProvider,
                                Widget? child) {
                              return wishProvider.addRemoveWishListLoading
                                  ? const SizedBox()
                                  : Positioned(
                                      bottom: -8,
                                      right: 1,
                                      child: FloatingActionButton(
                                        mini: true,
                                        heroTag: wishListData.image!,
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.white,
                                        child: const Icon(
                                          CupertinoIcons.heart_fill,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          wishProvider.addRemoveWishListApi(
                                              from: AppStrings.fromWishList,
                                              productId:
                                                  wishListData.productId!,
                                              wishStatus: "1",
                                              context: context);
                                        },
                                      ),
                                    );
                            },
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
                          wishListData.productName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          wishListData.sku!,
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
