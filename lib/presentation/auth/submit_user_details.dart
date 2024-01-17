import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/address/address_api_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/loader_widget.dart';

class SubmitUserDetailsScreen extends StatefulWidget {
  const SubmitUserDetailsScreen({super.key});

  @override
  State<SubmitUserDetailsScreen> createState() =>
      _SubmitUserDetailsScreenState();
}

class _SubmitUserDetailsScreenState extends State<SubmitUserDetailsScreen> {
  TextEditingController zipController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ValueNotifier<String?> selectedState = ValueNotifier<String?>(null);
  ValueNotifier<String?> selectedCity = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var addressProvider =
        Provider.of<AddressApiProvider>(context, listen: false);
    addressProvider.setLoaderFalseDataNull();
    await addressProvider.getStateApi();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppStrings.fillDetailsScreenTitle)
            .animate()
            .fadeIn(duration: 500.ms),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.ph,
                CustomLabelWidget(
                  labelText: AppStrings.stateLabel,
                  mandatory: true,
                ),
                5.ph,
                Consumer<AddressApiProvider>(
                  builder:
                      (BuildContext context, addressProvider, Widget? child) {
                    return addressProvider.stateLoading
                        ? Shimmer.fromColors(
                            baseColor: AppColors.grey100,
                            highlightColor: AppColors.grey300,
                            child: Container(
                              width: mq.width,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: AppColors.textFieldBgColor,
                              ),
                              padding: const EdgeInsets.only(right: 4),
                            ),
                          )
                        : ValueListenableBuilder(
                            valueListenable: selectedState,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Container(
                                width: mq.width,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: AppColors.textFieldBgColor,
                                ),
                                padding: const EdgeInsets.only(right: 4),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: selectedState.value,
                                      isExpanded: true,
                                      hint: Text(
                                        "--Select State--",
                                        style: AppTextStyles.bodyBlack14,
                                      ),
                                      style: AppTextStyles.bodyBlack14,
                                      onChanged: (data) async {
                                        debugPrint("value $data");
                                        selectedState.value = data!;
                                        selectedCity.value = null;
                                        addressProvider.getCityApi(
                                            stateId: selectedState.value!);
                                      },
                                      items: addressProvider
                                          .stateModel?.stateData
                                          ?.map(
                                        (item) {
                                          return DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: FittedBox(
                                              child: Text(
                                                item.stateName.toString(),
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.cityLabel,
                  mandatory: true,
                ),
                5.ph,
                Consumer<AddressApiProvider>(
                  builder:
                      (BuildContext context, addressProvider, Widget? child) {
                    return addressProvider.cityLoading
                        ? Shimmer.fromColors(
                            baseColor: AppColors.grey100,
                            highlightColor: AppColors.grey300,
                            child: Container(
                              width: mq.width,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: AppColors.textFieldBgColor,
                              ),
                              padding: const EdgeInsets.only(right: 4),
                            ),
                          )
                        : ValueListenableBuilder(
                            valueListenable: selectedCity,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Container(
                                width: mq.width,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: AppColors.textFieldBgColor,
                                ),
                                padding: const EdgeInsets.only(right: 4),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: selectedCity.value,
                                      isExpanded: true,
                                      hint: Text(
                                        "--Select City--",
                                        style: AppTextStyles.bodyBlack14,
                                      ),
                                      style: AppTextStyles.bodyBlack14,
                                      onChanged: (data) async {
                                        debugPrint("value $data");
                                        selectedCity.value = data!;
                                      },
                                      items: addressProvider
                                          .cityModel?.districtData
                                          ?.map(
                                        (item) {
                                          return DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: FittedBox(
                                              child: Text(
                                                item.districtName.toString(),
                                                style:
                                                    AppTextStyles.bodyBlack14,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.zipLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: zipController,
                  hintText: AppStrings.zipHint,
                  keyboardType: TextInputType.number,
                  digitOnly: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ZIP code.';
                    }
                    /* if (value.length < 10) {
                      return 'Invalid mobile number';
                    }*/
                    return null;
                  },
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.landmarkLabel,
                  mandatory: false,
                ),
                5.ph,
                CustomTextField(
                  textController: landmarkController,
                  hintText: AppStrings.landmarkHint,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.addressLabel,
                  mandatory: true,
                ),
                5.ph,
                CustomTextField(
                  textController: addressController,
                  hintText: AppStrings.addressHint,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  maxLine: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address.';
                    }
                    return null;
                  },
                ),
                20.ph,
                Consumer<AddressApiProvider>(
                  builder:
                      (BuildContext context, addressProvider, Widget? child) {
                    return addressProvider.addAddressLoading
                        ? const CustomButtonLoader()
                        : CustomButton(
                            onPressed: () {
                              removeFocus(context);
                              if (selectedState.value == null) {
                                Utils.showToast("Please select a state");
                                return;
                              }
                              if (selectedCity.value == null) {
                                Utils.showToast("Please select a city");
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                addressProvider.addAddress(
                                    context: context,
                                    stateId: selectedState.value!,
                                    cityId: selectedCity.value!,
                                    address: addressController.text.trim(),
                                    zipCode: zipController.text.trim(),
                                    landMark: landmarkController.text.trim(),
                                    primaryStatus: "1",
                                    fromScreen: AppStrings.fromRegisterScreen);
                              }
                            },
                            isGradient: false,
                            child: Text(
                              AppStrings.submitTxt.toUpperCase(),
                              style: AppTextStyles.bodyWhite16,
                            ),
                          ).animate().fadeIn(duration: 500.ms);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
