import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/logic/services/formatter.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:samrathal_ecart/widgets/photo_view_screen.dart';
import '../../../../core/api_const.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/payment_api_provider.dart';
import '../../../../widgets/navigate_anim.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final String orderPaymentId;

  const PaymentDetailsScreen({super.key, required this.orderPaymentId});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var dataProvider = Provider.of<PaymentApiProvider>(context, listen: false);
    dataProvider.setOrderPaymentDetailsNull();
    await dataProvider.getOrderPaymentDetailsData(
        paymentId: widget.orderPaymentId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.paymentDetailsTxt)
            .animate()
            .fadeIn(duration: 500.ms),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<PaymentApiProvider>(
          builder: (BuildContext context, PaymentApiProvider paymentProvider,
              Widget? child) {
            var paymentDetailsModel = paymentProvider.orderPaymentDetailsModel;
            var paymentDetailsData =
                paymentProvider.orderPaymentDetailsModel?.getPaymentDetailsData;
            var qrImgPath =
                paymentProvider.orderPaymentDetailsModel?.qrImagePath;
            var paymentImgPath =
                paymentProvider.orderPaymentDetailsModel?.paymentImagePath;
            return paymentProvider.orderPaymentDetailsLoading
                ? const SpinKitCircle(
                    color: AppColors.primaryColor,
                  )
                : paymentDetailsModel != null && paymentDetailsData != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Payment Screenshot",
                                        style: AppTextStyles.bodyBlack14
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    if (paymentImgPath != null &&
                                        paymentDetailsData.paymentImage != null)
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            FadeAnimatingRoute(
                                              route: PhotoViewScreen(
                                                  imgUrl: ApiEndPoints.baseUrl +
                                                      paymentImgPath +
                                                      paymentDetailsData
                                                          .paymentImage!),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: ApiEndPoints.baseUrl +
                                              paymentImgPath +
                                              paymentDetailsData.paymentImage!,
                                          fit: BoxFit.fill,
                                          height: 30,
                                          width: 30,
                                          placeholder: (context, url) =>
                                              const SizedBox(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                  ],
                                ),
                                5.ph,
                                PaymentDetailsItems(
                                    title: "Paid Amount",
                                    desc: Formatter.formatPrice(num.parse(
                                        paymentDetailsData.payAmount!))),
                                if (paymentDetailsData.paymentType == 1)
                                  Column(
                                    children: [
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.bankNameTxt,
                                          desc: paymentDetailsData.bankName!),
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.acNumberTxt,
                                          desc: paymentDetailsData
                                              .accountNumber!),
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.acHolderName,
                                          desc: paymentDetailsData.holderName!),
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.ifscCodeTxt,
                                          desc: paymentDetailsData.ifscCode!),
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.micrCodeTxt,
                                          desc: paymentDetailsData.micrCode!),
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.branchNameTxt,
                                          desc: paymentDetailsData.branch!),
                                    ],
                                  ),
                                if (paymentDetailsData.paymentType == 2)
                                  Column(
                                    children: [
                                      5.ph,
                                      PaymentDetailsItems(
                                          title: AppStrings.upiTxt,
                                          desc: paymentDetailsData.upiId!),
                                    ],
                                  ),
                                if (paymentDetailsData.paymentType == 3)
                                  Column(
                                    children: [
                                      5.ph,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Payment Via QR",
                                              style: AppTextStyles.bodyBlack14
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                          if (qrImgPath != null &&
                                              paymentDetailsData.qrCodeImage !=
                                                  null)
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  FadeAnimatingRoute(
                                                    route: PhotoViewScreen(
                                                        imgUrl: ApiEndPoints
                                                                .baseUrl +
                                                            qrImgPath +
                                                            paymentDetailsData
                                                                .qrCodeImage!),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: ApiEndPoints.baseUrl +
                                                    qrImgPath +
                                                    paymentDetailsData
                                                        .qrCodeImage!,
                                                fit: BoxFit.fill,
                                                height: 30,
                                                width: 30,
                                                placeholder: (context, url) =>
                                                    const SizedBox(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
          },
        ),
      ),
    );
  }
}

class PaymentDetailsItems extends StatelessWidget {
  final String title;
  final String desc;

  const PaymentDetailsItems(
      {super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        // const Text(":"),
        Expanded(
          child: Text(
            desc,
            textAlign: TextAlign.right,
            style:
                AppTextStyles.bodyBlack14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
