import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/wishlist/wishlist_api_provider.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../data/model/dashboard/dashboard_data_model.dart';
import '../../../../widgets/navigate_anim.dart';
import '../../shop/product_details_screen.dart';

class ProductListCard extends StatelessWidget {
  final ProductData productData;
  final String productImgPath;

  const ProductListCard(
      {super.key, required this.productImgPath, required this.productData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          FadeAnimatingRoute(
            route: ProductDetailsScreen(
              productId: productData.id!,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 120,
            // color: Colors.grey,
            margin: const EdgeInsets.only(right: 16),
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
                          //   productData!.image!,
                          //   fit: BoxFit.fill,
                          //   width: double.infinity,
                          //   height: double.infinity,
                          // ),
                          CachedNetworkImage(
                            imageUrl: ApiEndPoints.baseUrl +
                                productImgPath +
                                productData.image!,
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
                                        heroTag: productData.image!,
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.white,
                                        child: productData.wishlistStatus !=
                                                    null &&
                                                productData.wishlistStatus == 1
                                            ? const Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Colors.red,
                                              )
                                            : const Icon(CupertinoIcons.heart),
                                        onPressed: () {
                                          if (productData.wishlistStatus == 0) {
                                            wishProvider.addRemoveWishListApi(
                                                from: AppStrings.fromHome,
                                                productId: productData.id!,
                                                wishStatus: "0",
                                                context: context);
                                          } else {
                                            wishProvider.addRemoveWishListApi(
                                                from: AppStrings.fromHome,
                                                productId: productData.id!,
                                                wishStatus: "1",
                                                context: context);
                                          }
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
                          productData.productName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          productData.sku!,
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
          Positioned(
            top: 5,
            left: 3,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 5),
              child: Text(
                "Featured",
                style: AppTextStyles.bodyWhite10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
