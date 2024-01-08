import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/label_widget.dart';
import '../dashboard/dashboard_screen.dart';

class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  static const String routeName = "Register Company Screen";

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  ValueNotifier<String?> selectedState = ValueNotifier<String?>(null);
  ValueNotifier<String?> selectedCity = ValueNotifier<String?>(null);

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
        elevation: 0.0,
        centerTitle: true,
        title: Text(AppStrings.fillDetailsScreenTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              20.ph,
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    // Added top padding for title
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLabelWidget(
                          labelText: AppStrings.companyNameLabel,
                          mandatory: true,
                        ),
                        5.ph,
                        CustomTextField(
                          hintText: AppStrings.companyNameHint,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        16.ph,
                        CustomLabelWidget(
                          labelText: AppStrings.gstNumberLabel,
                          mandatory: true,
                        ),
                        5.ph,
                        CustomTextField(
                          hintText: AppStrings.gstNumberHint,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        16.ph,
                        CustomLabelWidget(
                          labelText: AppStrings.billingAddressLabel,
                          mandatory: true,
                        ),
                        5.ph,
                        CustomTextField(
                          hintText: AppStrings.billingAddressHint,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLine: 3,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -8,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.white,
                      child: Text('Company Details',
                          style: AppTextStyles.bodyBlack14
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              16.ph,
              CustomLabelWidget(
                labelText: AppStrings.stateLabel,
                mandatory: true,
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
              20.ph,
              CustomButton(
                onPressed: () {
                  removeFocus(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, DashboardScreen.routeName, (route) => false,
                      arguments: 0);
                },
                isGradient: false,
                child: Text(
                  AppStrings.submitTxt.toUpperCase(),
                  style: AppTextStyles.bodyWhite16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
