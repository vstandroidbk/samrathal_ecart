import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../core/api_const.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_styles.dart';
import '../../../logic/provider/dashboard/home/home_api_provider.dart';
import '../../../logic/services/formatter.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/loader_widget.dart';
import 'widget/offer_details_shimmer.dart';

class OfferDetailsScreen extends StatefulWidget {
  final String offerId;

  const OfferDetailsScreen({super.key, required this.offerId});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<HomeApiProvider>(context, listen: false);
    dataProvider.setOfferDetailsDataNull();
    dataProvider.setOptOfferFalse();
    await dataProvider.getOfferDetailsApi(offerId: widget.offerId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offer Details"),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Consumer<HomeApiProvider>(
            builder: (BuildContext context, HomeApiProvider homeProvider,
                Widget? child) {
              var offerDetailsModel = homeProvider.offerDetailsModel;
              var offerImgPath = homeProvider.offerDetailsModel?.offerImagePath;
              var offerDetails = homeProvider.offerDetailsModel?.offerDetails;

              return homeProvider.offerDetailsLoading
                  ? const OfferDetailsShimmer()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        if (offerDetailsModel != null &&
                            offerDetails != null &&
                            offerDetails.offerImage != null &&
                            offerImgPath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: ApiEndPoints.baseUrl +
                                  offerImgPath +
                                  offerDetails.offerImage!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                              placeholder: (context, url) => const SizedBox(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        //
                        16.ph,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.startDateTxt.toUpperCase(),
                                    style: AppTextStyles.bodyBlack14
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  5.ph,
                                  if (offerDetailsModel != null &&
                                      offerDetails != null &&
                                      offerDetails.startDate != null)
                                    Text(
                                      Formatter.formatDate(DateTime.parse(
                                          offerDetails.startDate!)),
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    AppStrings.endDateTxt.toUpperCase(),
                                    style: AppTextStyles.bodyBlack14
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  5.ph,
                                  if (offerDetailsModel != null &&
                                      offerDetails != null &&
                                      offerDetails.endDate != null)
                                    Text(
                                      Formatter.formatDate(DateTime.parse(
                                          offerDetails.endDate!)),
                                      style: AppTextStyles.bodyBlack14.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        16.ph,
                        Text(
                          AppStrings.offerTitleTxt,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (offerDetailsModel != null &&
                            offerDetails != null &&
                            offerDetails.title != null)
                          Text(
                            offerDetails.title!,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(color: AppColors.descColor),
                          ),
                        16.ph,
                        Text(
                          AppStrings.descriptionTxt,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (offerDetailsModel != null &&
                            offerDetails != null &&
                            offerDetails.description != null)
                          Text(
                            offerDetails.description!,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(color: AppColors.descColor),
                          ),
                        20.ph,
                        offerDetailsModel!.offerOptStatus != null &&
                                offerDetailsModel.offerOptStatus! == 1
                            ? CustomButton(
                                onPressed: () {},
                                isGradient: false,
                                backgroundColor: AppColors.greyColor,
                                child: Text(
                                  AppStrings.optOfferTxt,
                                  style: TextStyle(color: Colors.grey.shade500),
                                ))
                            : Consumer<HomeApiProvider>(
                                builder: (BuildContext context,
                                    HomeApiProvider homeProvider,
                                    Widget? child) {
                                  return homeProvider.optOfferLoading
                                      ? const CustomButtonLoader()
                                      : CustomButton(
                                          onPressed: () {
                                            homeProvider.optOfferApi(
                                                offerId: widget.offerId,
                                                context: context);
                                          },
                                          isGradient: false,
                                          child: Text(
                                            AppStrings.optOfferTxt,
                                            style: AppTextStyles.bodyWhite14,
                                          ),
                                        );
                                },
                              ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
