import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/add_address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/widget/address_shimmer_view.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/widget/address_view_card.dart';
import 'package:samrathal_ecart/widgets/no_data_found.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/provider/dashboard/profile/address/address_api_provider.dart';
import '../../../../widgets/custom_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  // static const String routeName = "Address page";

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.addressTxt).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
      body: Consumer<AddressApiProvider>(
        builder: (BuildContext context, AddressApiProvider addressApiProvider,
            Widget? child) {
          var data = addressApiProvider.addressListModel;
          return addressApiProvider.getAddressLoading
              ? const AddressShimmerView()
              : data != null && data.addressData != null
                  ? data.addressData!.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          itemCount: data.addressData!.length,
                          itemBuilder: (ctx, index) {
                            return AddressViewCard(
                              index: index,
                              addressData: data.addressData![index],
                            );
                          },
                        ).animate().slideY(
                            duration: 500.ms,
                          )
                      : const NoDataFound()
                  : const SizedBox();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: CustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAddressPage(),
              ),
            ).then((value) {
              callApi();
            });
          },
          isGradient: false,
          child: Text(
            AppStrings.addAddressTxt.toUpperCase(),
            style: AppTextStyles.bodyWhite14,
          ),
        ).animate().fadeIn(
              duration: 500.ms,
            ),
      ),
    );
  }
}
