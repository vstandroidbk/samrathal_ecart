import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/add_address_page.dart';
import 'package:samrathal_ecart/utils/utils.dart';

import '../../../../core/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../core/app_colors.dart';
import '../profile/address/edit_address_page.dart';

class SelectAddressPage extends StatefulWidget {
  const SelectAddressPage({super.key});

  // static const String routeName = "Select Address page";

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  int selectedIndex = -1; // Track the selected index, -1 for no selection

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
        itemCount: 4,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: SelectAddressViewCard(
              index: index,
              selectedIndex: selectedIndex,
            ),
          );
        },
      ).animate().slideY(
        duration: 500.ms,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                isGradient: false,
                child: Text(
                  "Deliver Here".toUpperCase(),
                  style: AppTextStyles.bodyWhite14,
                ),
              ).animate().fadeIn(
                duration: 500.ms,
              ),
            ),
            12.ph,
            SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressPage(),
                    ),
                  );
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
  final int index;
  final int selectedIndex;

  const SelectAddressViewCard(
      {super.key, required this.index, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /* if (index == 0)
          Container(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            padding:
            const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Text(
              "Primary",
              style: AppTextStyles.bodyWhite12,
            ),
          ),*/
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
                      "212-B Abc nagar def road ghk area, vggfddgu dgvdjhcgvg khdhvjvd (123456)",
                      style: AppTextStyles.bodyBlack14,
                    ),
                  ),
                  8.pw,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditAddressPage(),
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

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int selectedIndex = -1; // Track the selected index, -1 for no selection
  List<String> addresses = [
    '123 Main St',
    '456 Elm St',
    '789 Oak St',
    '101 Pine St',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selectable Address List'),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(addresses[index]),
            selected: index == selectedIndex,
            onTap: () {
              setState(() {
                selectedIndex = index; // Update the selected index
              });
            },
          );
        },
      ),
    );
  }
}
