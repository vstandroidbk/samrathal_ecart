import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/shop/shop_api_provider.dart';
import 'package:samrathal_ecart/presentation/dashboard/shop/widget/product_list_shimmer.dart';
import 'package:samrathal_ecart/presentation/dashboard/shop/widget/shop_product_list_card.dart';
import 'package:samrathal_ecart/widgets/no_data_found.dart';

class ShopTabPage extends StatefulWidget {
  const ShopTabPage({super.key});

  @override
  State<ShopTabPage> createState() => _ShopTabPageState();
}

class _ShopTabPageState extends State<ShopTabPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<ShopApiProvider>(context, listen: false);
    dataProvider.setProductListDataNull();
    await dataProvider.getProductListApi();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: const Text("Product List").animate().fadeIn(duration: 500.ms),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<ShopApiProvider>(
          builder: (BuildContext context, ShopApiProvider shopProvider,
              Widget? child) {
            var productModel = shopProvider.productListModel;
            var productList = shopProvider.productListModel?.productListData;
            var productImgPath =
                shopProvider.productListModel?.productImagePath;
            return shopProvider.productListLoading
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
                                return ShopProductListCard(
                                  productListData: productList[index],
                                  productImgPath: productImgPath,
                                );
                              },
                            ).animate().slideY(
                                  duration: 500.ms,
                                ),
                          )
                        : const NoDataFound()
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}
