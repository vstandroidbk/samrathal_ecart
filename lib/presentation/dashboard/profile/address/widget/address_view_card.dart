import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../data/model/dashboard/profile/address/address_list_model.dart';
import '../../../../../widgets/navigate_anim.dart';
import '../edit_address_page.dart';

class AddressViewCard extends StatelessWidget {
  final int index;
  final AddressData addressData;

  const AddressViewCard(
      {super.key, required this.index, required this.addressData});

  @override
  Widget build(BuildContext context) {
    var fullAddress =
        "${addressData.address} ${addressData.landmark} ${addressData.districtData?.districtName} ${addressData.stateData?.stateName} (${addressData.zipCode})";
    return Stack(
      children: [
        if (addressData.primaryStatus == 2)
          Container(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
            child: Text(
              "Primary",
              style: AppTextStyles.bodyWhite12,
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: const BoxDecoration(
            color: AppColors.profileLabelBg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
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
