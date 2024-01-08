import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/add_address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/widget/address_view_card.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  static const String routeName = "Address page";

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppStrings.addressTxt),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: 2,
        itemBuilder: (ctx, index) {
          return AddressViewCard(
            index: index,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, AddAddressPage.routeName);
          },
          isGradient: false,
          child: Text(
            AppStrings.addAddressTxt.toUpperCase(),
            style: AppTextStyles.bodyWhite14,
          ),
        ),
      ),
    );
  }
}
