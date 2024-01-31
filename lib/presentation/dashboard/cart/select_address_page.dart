import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_strings.dart';
import '../../../data/model/dashboard/profile/address/address_list_model.dart';
import '../../../logic/provider/dashboard/profile/address/address_api_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../widgets/loader_widget.dart';
import '../../../widgets/navigate_anim.dart';
import '../../../widgets/no_data_found.dart';
import '../profile/address/add_address_page.dart';
import '../profile/address/edit_address_page.dart';
import '../profile/address/widget/address_shimmer_view.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int selectedIndex = -1; // Track the selected index, -1 for no selection

  @override
  void initState() {
    callApi();
    super.initState();
  }

  Future<void> callApi() async {
    var addressProvider =
        Provider.of<AddressApiProvider>(context, listen: false);
    addressProvider.setLoaderFalseDataNull();
    await addressProvider.getAddressList();
    _refreshController.refreshCompleted();
    var data = addressProvider.addressListModel;
    if (data != null &&
        data.addressData != null &&
        data.addressData!.isNotEmpty) {
      for (int i = 0; i < data.addressData!.length; i++) {
        if (data.addressData![i].primaryStatus == 2) {
          selectedIndex = i;
          log("selected index is $selectedIndex");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.addressTxt),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          callApi();
        },
        child: Consumer<AddressApiProvider>(
          builder: (BuildContext context, AddressApiProvider addressApiProvider,
              Widget? child) {
            var data = addressApiProvider.addressListModel;
            return addressApiProvider.getAddressLoading
                ? const AddressShimmerView()
                : data != null && data.addressData != null
                    ? data.addressData!.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            itemCount: data.addressData!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  log("selected index is $selectedIndex");
                                },
                                child: SelectAddressViewCard(
                                  index: index,
                                  selectedIndex: selectedIndex,
                                  addressData: data.addressData![index],
                                ),
                              );
                            },
                          ).animate().slideY(
                              duration: 500.ms,
                            )
                        : const NoDataFound()
                    : const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<AddressApiProvider>(
              builder: (BuildContext context,
                  AddressApiProvider addressProvider, Widget? child) {
                var data = addressProvider.addressListModel;
                return addressProvider.updatePrimaryAddressLoading
                    ? const SizedBox(height: 40, child: CustomButtonLoader())
                    : data != null &&
                            data.addressData != null &&
                            data.addressData!.isNotEmpty
                        ? SizedBox(
                            height: 40,
                            child: CustomButton(
                              onPressed: () {
                                if (selectedIndex == -1) {
                                  Utils.showToast("Please select an address");
                                }
                                addressProvider
                                    .updatePrimaryAddress(
                                        addressId: data
                                            .addressData![selectedIndex].id!)
                                    .then((value) {
                                  if (mounted && value != null && value) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              isGradient: false,
                              child: Text(
                                "Deliver Here".toUpperCase(),
                                style: AppTextStyles.bodyWhite14,
                              ),
                            ).animate().fadeIn(
                                  duration: 500.ms,
                                ),
                          )
                        : const SizedBox();
              },
            ),
            12.ph,
            SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    FadeAnimatingRoute(
                      route: const AddAddressPage(),
                    ),
                  ).then((value) {
                    callApi();
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  side: const BorderSide(
                    width: 1.0,
                    color: AppColors.primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  AppStrings.addAddressTxt.toUpperCase(),
                  style: AppTextStyles.bodyBlack14
                      .copyWith(color: AppColors.primaryColor),
                ),
              ).animate().fadeIn(
                    duration: 500.ms,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectAddressViewCard extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final AddressData addressData;

  const SelectAddressViewCard(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.addressData});

  @override
  Widget build(BuildContext context) {
    var fullAddress =
        "${addressData.address} ${addressData.landmark} ${addressData.districtData?.districtName} ${addressData.stateData?.stateName} (${addressData.zipCode})";
    return Stack(
      children: [
        // if (index == selectedIndex)
        //   Container(
        //     decoration: const BoxDecoration(color: AppColors.primaryColor),
        //     padding:
        //         const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
        //     child: Text(
        //       "Primary",
        //       style: AppTextStyles.bodyWhite12,
        //     ),
        //   ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? AppColors.primaryColor.withOpacity(0.15)
                : AppColors.profileLabelBg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.0),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2)),
                  ),
                  8.pw,
                  Expanded(
                    child: Text(
                      fullAddress,
                      style: AppTextStyles.bodyBlack14,
                    ),
                  ),
                  8.pw,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeAnimatingRoute(
                          route: EditAddressPage(
                            addressId: addressData.id!,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Edit",
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
