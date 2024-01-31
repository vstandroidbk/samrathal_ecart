import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../logic/provider/dashboard/home/home_api_provider.dart';
import '../../../widgets/no_data_found.dart';
import 'widget/offer_list_card.dart';
import 'widget/offer_list_shimmer.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({super.key});

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<HomeApiProvider>(context, listen: false);
    dataProvider.setOfferListDataNull();
    await dataProvider.getOfferListApi();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offer List"),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<HomeApiProvider>(
          builder: (BuildContext context, HomeApiProvider homeProvider,
              Widget? child) {
            var offerData = homeProvider.offerListModel?.offerData;
            var offerModel = homeProvider.offerListModel;
            var offerImgPath = homeProvider.offerListModel?.offerImagePath;
            return homeProvider.offerListLoading
                ? const OfferListShimmer()
                : offerModel != null && offerImgPath != null
                    ? offerData != null && offerData.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            itemCount: offerData.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: OfferListCard(
                                  offerData: offerData[index],
                                  offerImgPath: offerImgPath,
                                ),
                              );
                            },
                          )
                        : const NoDataFound()
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}
