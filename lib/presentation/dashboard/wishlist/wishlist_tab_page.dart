import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';

import '../../../core/app_colors.dart';
import '../shop/product_details_screen.dart';

class WishlistTabPage extends StatefulWidget {
  const WishlistTabPage({super.key});

  @override
  State<WishlistTabPage> createState() => _WishlistTabPageState();
}

class _WishlistTabPageState extends State<WishlistTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 12,
          title: const Text("Wishlist"),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 30, // Spacing between columns
              mainAxisSpacing: 8, // Spacing between rows
              mainAxisExtent: 200),
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return WishlistProductListCard(index: index);
          },
        ));
  }
}

class WishlistProductListCard extends StatelessWidget {
  final int index;

  const WishlistProductListCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName);
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
                          Image.asset(
                            productList[index]["img"]!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            bottom: -8,
                            right: 1,
                            child: FloatingActionButton(
                              mini: true,
                              heroTag: index.toString(),
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              child: const Icon(
                                CupertinoIcons.heart_fill,
                                color: AppColors.primaryColor,
                              ),
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
                          productList[index]["name"]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          productList[index]["sku"]!,
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
          if (index % 2 != 0)
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
                  "Most Selling",
                  style: AppTextStyles.bodyWhite10,
                ),
              ),
            )
        ],
      ),
    );
  }
}
