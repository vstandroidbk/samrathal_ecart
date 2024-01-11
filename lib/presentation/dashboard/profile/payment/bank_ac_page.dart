import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/get_ac_details_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/get_amount_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/payment_success_screen.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import 'package:samrathal_ecart/widgets/label_widget.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';

class BankAcPage extends StatefulWidget {
  const BankAcPage({super.key});

  @override
  State<BankAcPage> createState() => _BankAcPageState();
}

class _BankAcPageState extends State<BankAcPage>
    with AutomaticKeepAliveClientMixin {
  List<BankDetails> listBank = [
    BankDetails(bankName: "BOB", ifscCode: "BOB123", acNumber: "7834787123321"),
    BankDetails(bankName: "PNB", ifscCode: "PNB123", acNumber: "7467476456654"),
    BankDetails(
        bankName: "ICICI", ifscCode: "ICICI123", acNumber: "798677678876"),
    BankDetails(
        bankName: "IDFC", ifscCode: "IDFC123", acNumber: "9877987890098"),
  ];

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
                itemCount: listBank.length,
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
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              if (selectedIndex != -1 &&
                                  selectedIndex == index) {
                                collapseAll(); // Collapse if the same item is tapped
                              } else {
                                toggleExpansion(index); // Toggle the visibility
                              }
                              log("selected account = $selectedIndex");
                              // setState(() {
                              //   selectedIndex = index;
                              // });
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
                                      child: Text(listBank[index].acNumber)),
                                  Icon(isExpanded
                                      ? Icons.arrow_drop_up // Upward arrow
                                      : Icons.arrow_drop_down),
                                  // Downward arrow)
                                ],
                              ),
                            ),
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetAcDetailsWidget(
                                      title: AppStrings.acNumberTxt,
                                      value: listBank[index].acNumber),
                                  5.ph,
                                  GetAcDetailsWidget(
                                      title: AppStrings.ifscCodeTxt,
                                      value: listBank[index].ifscCode),
                                  5.ph,
                                  GetAcDetailsWidget(
                                      title: AppStrings.micrCodeTxt,
                                      value: "kjh3344dd"),
                                  5.ph,
                                  GetAcDetailsWidget(
                                      title: AppStrings.bankNameTxt,
                                      value: listBank[index].bankName),
                                  5.ph,
                                  GetAcDetailsWidget(
                                      title: AppStrings.branchNameTxt,
                                      value: "Vaishali Nagar"),
                                ],
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
            ),
        /*Card(
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
                GetAcDetailsWidget(
                    title: AppStrings.acNumberTxt, value: "87462456845487"),
                5.ph,
                GetAcDetailsWidget(
                    title: AppStrings.ifscCodeTxt, value: "ABCDGH"),
                5.ph,
                GetAcDetailsWidget(
                    title: AppStrings.micrCodeTxt, value: "kjh3344dd"),
                5.ph,
                GetAcDetailsWidget(
                    title: AppStrings.bankNameTxt, value: "Bank of India"),
                5.ph,
                GetAcDetailsWidget(
                    title: AppStrings.branchNameTxt, value: "Vaishali Nagar"),
              ],
            ),
          ),
        ),*/
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
                GetAmountWidget(
                    title: AppStrings.totalOrderAmtTxt, value: 10000),
                5.ph,
                GetAmountWidget(
                    title: AppStrings.outStandingAmtTxt, value: 5000),
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

class BankDetails {
  String bankName;
  String ifscCode;
  String acNumber;

  BankDetails(
      {required this.bankName, required this.ifscCode, required this.acNumber});
}
