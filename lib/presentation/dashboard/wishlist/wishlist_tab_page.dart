import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/wishlist/wishlist_api_provider.dart';
import '../../../widgets/no_data_found.dart';
import '../shop/widget/product_list_shimmer.dart';
import 'widget/wishlist_card.dart';

class WishlistTabPage extends StatefulWidget {
  const WishlistTabPage({super.key});

  @override
  State<WishlistTabPage> createState() => _WishlistTabPageState();
}

class _WishlistTabPageState extends State<WishlistTabPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<WishlistApiProvider>(context, listen: false);
    dataProvider.setWishListDataNull();
    dataProvider.setAddRemoveWishListDataNull();
    await dataProvider.getWishListApi();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: const Text("Wishlist")
            .animate()
            .fadeIn(duration: 500.ms)
            .animate()
            .fadeIn(duration: 500.ms),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<WishlistApiProvider>(
          builder: (BuildContext context, WishlistApiProvider wishlistProvider,
              Widget? child) {
            var productModel = wishlistProvider.wishListModel;
            var productList = wishlistProvider.wishListModel?.wishListData;
            var productImgPath =
                wishlistProvider.wishListModel?.productImagePath;
            return wishlistProvider.wishListLoading
                ? const ProductListShimmer()
                : productModel != null && productImgPath != null
                    ? productList != null && productList.isNotEmpty
                        ? SingleChildScrollView(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // Number of columns in the grid
                                      crossAxisSpacing:
                                          30, // Spacing between columns
                                      mainAxisSpacing:
                                          8, // Spacing between rows
                                      mainAxisExtent: 200),
                              itemCount: productList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return WishlistProductListCard(
                                  wishListData: productList[index],
                                  productImgPath: productImgPath,
                                );
                              },
                            ).animate().slideY(duration: 500.ms),
                          )
                        : const NoDataFound()
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}
