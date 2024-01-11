import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/get_ac_details_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/payment_success_screen.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_images.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/services/formatter.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/label_widget.dart';
import 'dart:io';

class UpiPage extends StatefulWidget {
  const UpiPage({super.key});

  @override
  State<UpiPage> createState() => _UpiPageState();
}

class _UpiPageState extends State<UpiPage> with AutomaticKeepAliveClientMixin {
  List<String> upiList = ["abcd@ybl", "defghi@kotak", "jklmn@paytm"];

  var selectedIndex = -1;

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
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // account details
        ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: upiList.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            log("selected account = $selectedIndex");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12, bottom: 12),
                            child: Row(
                              children: [
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: index == selectedIndex
                                      ? BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.red,
                                          shape: BoxShape.circle)
                                      : BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: GetAcDetailsWidget(
                                      title: AppStrings.upiTxt,
                                      value: upiList[index]),
                                ),
                                // Downward arrow)
                              ],
                            ),
                          ),
                        ),
                      ));
                }).animate().slide(
              duration: 500.ms,
              begin: const Offset(-1, 0),
              // end: Offset(dx, dy),
            ),
        // 12.ph,
        // total and remaining amount
        Card(
          surfaceTintColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      AppStrings.totalOrderAmtTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
                    const Text(":"),
                    Expanded(
                        child: Text(
                      Formatter.formatPrice(10000),
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                5.ph,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      AppStrings.outStandingAmtTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
                    const Text(":"),
                    Expanded(
                        child: Text(
                      Formatter.formatPrice(5000),
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
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
        Container(
          height: 45,
          padding: const EdgeInsets.only(left: 12, right: 8),
          decoration: const BoxDecoration(color: AppColors.textFieldBgColor),
          child: InkWell(
            onTap: () {
              chooseImage();
            },
            child: ValueListenableBuilder(
              valueListenable: selectedImage,
              builder: (BuildContext context, value, Widget? child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        selectedImage.value == null
                            ? AppStrings.uploadScreenshotTxt
                            : imageName.value!,
                        style: AppTextStyles.bodyBlack14
                            .copyWith(color: AppColors.textHintColor),
                      ),
                    ),
                    8.pw,
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: selectedImage,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return value != null
                                ? Image.file(
                                    value,
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
                        if (selectedImage.value != null)
                          InkWell(
                            onTap: () {
                              selectedImage.value = null;
                              imageName.value = null;
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
            hintText: AppStrings.amtHintTxt,
            prefixIcon: const Icon(
              Icons.currency_rupee,
              color: AppColors.textHintColor,
            ),
            digitOnly: true,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
          ),
        ).animate().slide(
              duration: 500.ms,
              begin: const Offset(1, 0),
              // end: Offset(dx, dy),
            ),
        20.ph,
        CustomButton(
          onPressed: () {
            removeFocus(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PaymentSuccessScreen(),
              ),
            );
          },
          isGradient: false,
          child: Text(
            AppStrings.submitTxt.toUpperCase(),
            style: AppTextStyles.bodyWhite14,
          ),
        ).animate().fadeIn(duration: 500.ms),
      ],
    );
  }
}
