import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/address/address_api_provider.dart';
import '../../../../logic/provider/dashboard/profile/address/location_data_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/label_widget.dart';
import '../../../../widgets/loader_widget.dart';
import '../../../../widgets/navigate_anim.dart';
import 'pick_location_screen.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  ValueNotifier<String?> selectedState = ValueNotifier<String?>(null);
  ValueNotifier<String?> selectedCity = ValueNotifier<String?>(null);
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

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
        centerTitle: true,
        title: Text(AppStrings.addAddressTxt).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
      body: SizedBox(
        width: mq.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  25.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomLabelWidget(
                        labelText: AppStrings.stateLabel,
                        mandatory: true,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            FadeAnimatingRoute(
                              route: const PickLocationScreen(),
                            ),
                          ).then((value) async {
                            var locationProvider =
                                Provider.of<LocationProvider>(context,
                                    listen: false);
                            if (locationProvider.zipCode != null) {
                              zipController.text = locationProvider.zipCode!;
                            }
                            if (locationProvider.address != null) {
                              addressController.text =
                                  locationProvider.address!;
                            }
                            if (locationProvider.address != null) {
                              landmarkController.text =
                                  locationProvider.landmark!;
                            }
                            var addressProvider =
                                Provider.of<AddressApiProvider>(context,
                                    listen: false);
                            if (locationProvider.state != null &&
                                addressProvider.stateModel != null &&
                                addressProvider.stateModel!.stateData != null &&
                                addressProvider
                                    .stateModel!.stateData!.isNotEmpty) {
                              var stateId = findStateIdByName(
                                  addressProvider.stateModel?.stateData,
                                  locationProvider.state!);
                              selectedState.value = stateId;
                              selectedCity.value = null;
                              if (selectedState.value != null) {
                                await addressProvider.getCityApi(
                                    stateId: selectedState.value!);
                              } else {
                                addressProvider.clearCity();
                              }
                              if (locationProvider.city != null &&
                                  addressProvider.cityModel != null &&
                                  addressProvider.cityModel!.districtData !=
                                      null &&
                                  addressProvider
                                      .cityModel!.districtData!.isNotEmpty) {
                                var cityId = findCityIdByName(
                                    addressProvider.cityModel?.districtData,
                                    locationProvider.city!);
                                selectedCity.value = cityId;
                              }
                            }
                            log("location data: ${locationProvider.address} ${locationProvider.state} ${locationProvider.city} ${locationProvider.latitude} ${locationProvider.longitude}");
                          });
                        },
                        child: Text(
                          AppStrings.picLocationTxt,
                          style: AppTextStyles.bodyBlack14
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      )
                    ],
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
                    // maxLength: 6,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
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
                      if (value!.trim().isEmpty) {
                        return 'Please enter address.';
                      }
                      return null;
                    },
                  ),
                  16.ph,
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16.0,
                          height: 16.0,
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Make This Primary',
                          style: AppTextStyles.bodyBlack14,
                        ),
                      ],
                    ),
                  ),
                  20.ph,
                  Consumer<AddressApiProvider>(
                    builder:
                        (BuildContext context, addressProvider, Widget? child) {
                      return addressProvider.addAddressLoading
                          ? const CustomButtonLoader()
                          : CustomButton(
                              onPressed: () async {
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
                                  var addressResp =
                                      await addressProvider.addAddress(
                                          context: context,
                                          stateId: selectedState.value!,
                                          cityId: selectedCity.value!,
                                          address:
                                              addressController.text.trim(),
                                          zipCode: zipController.text.trim(),
                                          landMark:
                                              landmarkController.text.trim(),
                                          primaryStatus: isChecked ? "2" : "1",
                                          fromScreen: "");
                                  if (addressResp != null && addressResp) {
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
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
        ).animate().slideX(
              duration: 500.ms,
            ),
      ),
    );
  }
}
