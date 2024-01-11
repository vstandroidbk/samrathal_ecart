import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/location_data_provider.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/label_widget.dart';
import '../../../pick_location_screen.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  // static const String routeName = "Edit Address Page";

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  ValueNotifier<String?> selectedState = ValueNotifier<String?>(null);
  ValueNotifier<String?> selectedCity = ValueNotifier<String?>(null);

  bool isChecked = false;
  List<Map<String, dynamic>> stateList = [
    {"id": "1", "name": "Rajasthan"},
    {"id": "2", "name": "UP"},
    {"id": "3", "name": "Mp"}
  ];

  List<Map<String, dynamic>> cityList = [
    {"id": "1", "name": "Jaipur"},
    {"id": "2", "name": "Jhodpur"},
    {"id": "3", "name": "Alwar"}
  ];

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.editAddressTxt).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
      body: SizedBox(
        width: mq.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          MaterialPageRoute(
                            builder: (context) => const PickLocationScreen(),
                          ),
                        ).then((value) {
                          var locationProvider = Provider.of<LocationProvider>(
                              context,
                              listen: false);
                          log("location data: ${locationProvider.address} ${locationProvider.latitude} ${locationProvider.longitude}");
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
                ValueListenableBuilder(
                  valueListenable: selectedState,
                  builder: (BuildContext context, value, Widget? child) {
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
                            },
                            items: stateList.map(
                              (item) {
                                return DropdownMenuItem(
                                  value: item["id"].toString(),
                                  child: FittedBox(
                                    child: Text(
                                      item["name"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                ),
                16.ph,
                CustomLabelWidget(
                  labelText: AppStrings.cityLabel,
                  mandatory: true,
                ),
                5.ph,
                ValueListenableBuilder(
                  valueListenable: selectedCity,
                  builder: (BuildContext context, value, Widget? child) {
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
                            items: cityList.map(
                              (item) {
                                return DropdownMenuItem(
                                  value: item["id"].toString(),
                                  child: FittedBox(
                                    child: Text(
                                      item["name"].toString(),
                                      style: AppTextStyles.bodyBlack14,
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
                  maxLength: 6,
                  textInputAction: TextInputAction.done,
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
                  textInputAction: TextInputAction.next,
                  maxLine: 3,
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
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isGradient: false,
                  child: Text(
                    AppStrings.submitTxt.toUpperCase(),
                    style: AppTextStyles.bodyWhite14,
                  ),
                ).animate().fadeIn(
                      duration: 500.ms,
                    ),
              ],
            ),
          ),
        ).animate().slideX(
              duration: 500.ms,
            ),
      ),
    );
  }
}
