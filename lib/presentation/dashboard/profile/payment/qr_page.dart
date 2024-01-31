import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/core/api_const.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/payment_api_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/label_widget.dart';
import '../../../../widgets/loader_widget.dart';
import 'widget/get_amount_widget.dart';
import 'widget/upload_image_shimmer.dart';

class QrPage extends StatefulWidget {
  final String screenType;
  final String? addressId;
  final String? orderId;
  final String? orderToken;

  const QrPage(
      {super.key,
      required this.screenType,
      required this.addressId,
      this.orderId,
      this.orderToken});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState
    extends State<QrPage> /*with AutomaticKeepAliveClientMixin*/ {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController amountController = TextEditingController();
  var selectedIndex = -1;

  void toggleExpansion(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void collapseAll() {
    setState(() {
      selectedIndex = -1; // Collapse all items
    });
  }

  var selectedImage = ValueNotifier<File?>(null);
  var imageName = ValueNotifier<String?>(null);

  Future<void> chooseImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      selectedImage.value = File(image.path);
      imageName.value = selectedImage.value!.path.split('/').last;
      debugPrint("selected image $selectedImage ");
      debugPrint("selected image name $imageName ");
      debugPrint("selected image image ${image.toString()} ");
      FormData formData = FormData.fromMap({
        "photo": selectedImage.value == null
            ? ""
            : await MultipartFile.fromFile(selectedImage.value!.path,
                filename: imageName.value)
      });
      if (context.mounted) {
        var provider = Provider.of<PaymentApiProvider>(context, listen: false);
        provider.uploadImageFromPayment(formData: formData);
      }
    }
  }

  Future<void> callApi() async {
    var addressProvider =
        Provider.of<PaymentApiProvider>(context, listen: false);
    addressProvider.setPaymentMethodListNull();
    await addressProvider.getPaymentMethodListApi(
        screenType: widget.screenType, orderId: widget.orderId);
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<PaymentApiProvider>(context, listen: false);
    provider.setUploadImageDataNull();
  }

  /*@override
  bool get wantKeepAlive => true;
*/
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () {
        callApi();
      },
      child: Consumer<PaymentApiProvider>(
        builder: (BuildContext context, PaymentApiProvider paymentProvider,
            Widget? child) {
          var paymentDataModel = paymentProvider.paymentMethodListModel;
          var qrData = paymentProvider.paymentMethodListModel?.qrData;
          var qrImgPath = paymentProvider.paymentMethodListModel?.qrImagePath;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // account details
                  paymentDataModel != null &&
                          qrImgPath != null &&
                          qrData != null &&
                          qrData.isNotEmpty
                      ? ListView.builder(
                              itemCount: qrData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                bool isExpanded = index == selectedIndex;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Card(
                                    surfaceTintColor: Colors.white,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // if (selectedIndex != -1 &&
                                            //     selectedIndex == index) {
                                            //   collapseAll(); // Collapse if the same item is tapped
                                            // } else {
                                            //   toggleExpansion(
                                            //       index); // Toggle the visibility
                                            // }
                                            toggleExpansion(index);
                                            log("selected account = $selectedIndex");
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 12,
                                                bottom: 12),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 18,
                                                  decoration: index ==
                                                          selectedIndex
                                                      ? BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1),
                                                          color: Colors.red,
                                                          shape:
                                                              BoxShape.circle)
                                                      : BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1),
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        "QR ${index + 1}")),
                                                Icon(isExpanded
                                                    ? Icons
                                                        .arrow_drop_up // Upward arrow
                                                    : Icons.arrow_drop_down),
                                                // Downward arrow)
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (isExpanded)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                bottom: 12),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                ApiEndPoints.baseUrl +
                                                    qrImgPath +
                                                    qrData[index].qrCodeImage!,
                                                height: 180,
                                                width: 180,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                );
                              }).animate().slide(
                            duration: 500.ms,
                            begin: const Offset(-1, 0),
                            // end: Offset(dx, dy),
                          )
                      : Card(
                          surfaceTintColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset(
                                  AppImages.noDataImg,
                                  height: 80,
                                  width: 80,
                                ),
                                8.ph,
                                Text(
                                  "QR Data Not Available",
                                  style: AppTextStyles.bodyBlack14,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                  /*Card(
                    surfaceTintColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8),
                      child: Image.asset(
                        AppImages.sampleQrImg,
                        height: 180,
                        width: 180,
                      ),
                    ),
                  ).animate().slide(
                        duration: 500.ms,
                        begin: const Offset(-1, 0),
                        // end: Offset(dx, dy),
                      ),*/
                  12.ph,
                  // total and remaining amount
                  if (paymentDataModel != null &&
                      paymentDataModel.totalOrderAmount != null)
                    Card(
                      surfaceTintColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetAmountWidget(
                                title: AppStrings.totalOrderAmtTxt,
                                value: paymentDataModel.totalOrderAmount!),
                            5.ph,
                            if (paymentDataModel.totalOutstandingAmount != null)
                              GetAmountWidget(
                                  title: AppStrings.outStandingAmtTxt,
                                  value:
                                      paymentDataModel.totalOutstandingAmount!),
                          ],
                        ),
                      ),
                    ).animate().slide(
                          duration: 500.ms,
                          begin: const Offset(1, 0),
                          // end: Offset(dx, dy),
                        ),
                  12.ph,
                  CustomLabelWidget(
                    labelText: AppStrings.uploadScreenshotTxt,
                    mandatory: true,
                    fontSize: 14,
                  ).animate().slide(
                        duration: 500.ms,
                        begin: const Offset(1, 0),
                        // end: Offset(dx, dy),
                      ),
                  5.ph,
                  Consumer<PaymentApiProvider>(
                    builder: (BuildContext context,
                        PaymentApiProvider paymentProvider, Widget? child) {
                      var uploadModel = paymentProvider.uploadImageModel;
                      var uploadData = paymentProvider.uploadImageModel?.data;
                      return paymentProvider.uploadImageLoading
                          ? const UploadImageShimmer()
                          : Container(
                              height: 45,
                              padding:
                                  const EdgeInsets.only(left: 12, right: 8),
                              decoration: const BoxDecoration(
                                  color: AppColors.textFieldBgColor),
                              child: InkWell(
                                onTap: () {
                                  chooseImage();
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: selectedImage,
                                  builder: (BuildContext context, value,
                                      Widget? child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            uploadModel != null &&
                                                    uploadData != null &&
                                                    uploadData.filename !=
                                                        null &&
                                                    uploadData
                                                            .paymentImagePath !=
                                                        null
                                                ? uploadData.filename!
                                                : AppStrings
                                                    .uploadScreenshotTxt,
                                            style: AppTextStyles.bodyBlack14
                                                .copyWith(
                                                    color: AppColors
                                                        .textHintColor),
                                          ),
                                        ),
                                        8.pw,
                                        Row(
                                          children: [
                                            ValueListenableBuilder(
                                              valueListenable: selectedImage,
                                              builder: (BuildContext context,
                                                  value, Widget? child) {
                                                return uploadModel != null &&
                                                        uploadData != null &&
                                                        uploadData.filename !=
                                                            null &&
                                                        uploadData
                                                                .paymentImagePath !=
                                                            null
                                                    ? Image.network(
                                                        ApiEndPoints.baseUrl +
                                                            uploadData
                                                                .paymentImagePath! +
                                                            uploadData
                                                                .filename!,
                                                        width: 25,
                                                        height: 25,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        AppImages.uploadImg,
                                                        height: 25,
                                                        width: 25,
                                                      );
                                              },
                                            ),
                                            12.pw,
                                            if (uploadModel != null &&
                                                uploadData != null &&
                                                uploadData.filename != null &&
                                                uploadData.paymentImagePath !=
                                                    null)
                                              InkWell(
                                                onTap: () {
                                                  selectedImage.value = null;
                                                  imageName.value = null;
                                                  paymentProvider.clearImage();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: AppColors.primaryColor,
                                                ),
                                              )
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ).animate().slide(
                                duration: 500.ms,
                                begin: const Offset(1, 0),
                                // end: Offset(dx, dy),
                              );
                    },
                  ),
                  12.ph,
                  CustomLabelWidget(
                    labelText: AppStrings.amtPaidTxt,
                    mandatory: true,
                    fontSize: 14,
                  ).animate().slide(
                        duration: 500.ms,
                        begin: const Offset(1, 0),
                        // end: Offset(dx, dy),
                      ),
                  5.ph,
                  SizedBox(
                    height: 45,
                    child: CustomTextField(
                      textController: amountController,
                      hintText: AppStrings.amtHintTxt,
                      prefixIcon: const Icon(
                        Icons.currency_rupee,
                        color: AppColors.textHintColor,
                      ),
                      // digitOnly: true,
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                    ),
                  ).animate().slide(
                        duration: 500.ms,
                        begin: const Offset(1, 0),
                        // end: Offset(dx, dy),
                      ),
                  20.ph,
                  paymentProvider.orderPlaceLoading
                      ? const CustomButtonLoader()
                      : paymentDataModel != null &&
                              paymentDataModel.qrData != null &&
                              paymentDataModel.totalOrderAmount != null &&
                              paymentDataModel.totalOutstandingAmount != null
                          ? CustomButton(
                              onPressed: () {
                                var provider = Provider.of<PaymentApiProvider>(
                                    context,
                                    listen: false);
                                var amount = amountController.text.trim();
                                if (selectedIndex == -1) {
                                  Utils.showToast("Please select a QR");
                                  return;
                                }
                                if (provider.uploadImageModel == null ||
                                    provider.uploadImageModel?.data == null ||
                                    provider.uploadImageModel?.data?.filename ==
                                        null) {
                                  Utils.showToast(
                                      "Please select screenshot of payment");
                                  return;
                                }
                                if (amount.isEmpty) {
                                  Utils.showToast("Please enter amount");
                                  return;
                                }
                                num enteredAmount = num.parse(amount);
                                if (enteredAmount <= 0) {
                                  Utils.showToast(
                                      "Amount must be greater than zero");
                                  return;
                                }
                                if (enteredAmount >
                                    paymentDataModel.totalOutstandingAmount!) {
                                  Utils.showToast(
                                      "Amount cannot be greater than outstanding amount");
                                  return;
                                }
                                Map<String, dynamic> jsonData = {
                                  "orderToken":
                                      widget.screenType == AppStrings.fromCart
                                          ? "1"
                                          : widget.orderToken,
                                  "paymentImage":
                                      provider.uploadImageModel!.data!.filename,
                                  "payAmount": amount,
                                  "addressId": widget.addressId,
                                  "PaymentType": "3",
                                  "paymentId":
                                      paymentDataModel.qrData![selectedIndex].id
                                };
                                removeFocus(context);
                                provider.orderPlaceApi(
                                    jsonData: jsonData, context: context);
                              },
                              isGradient: false,
                              child: Text(
                                AppStrings.submitTxt.toUpperCase(),
                                style: AppTextStyles.bodyWhite14,
                              ),
                            ).animate().fadeIn(duration: 500.ms)
                          : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
