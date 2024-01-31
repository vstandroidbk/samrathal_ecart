import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/app_text_styles.dart';
import '../../../../logic/services/formatter.dart';
import '../../../../widgets/custom_button.dart';
import '../product_details_screen.dart';

class ProductDetailsShimmer extends StatefulWidget {
  const ProductDetailsShimmer({super.key});

  @override
  State<ProductDetailsShimmer> createState() => _ProductDetailsShimmerState();
}

class _ProductDetailsShimmerState extends State<ProductDetailsShimmer> {
  List<SizeInfo> sizes = [
    SizeInfo(id: 1, size: '5 kg'),
    SizeInfo(id: 2, size: '10 kg'),
    SizeInfo(id: 3, size: '25 kg'),
    SizeInfo(id: 5, size: 'Random'),
  ];

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // const ProductSliderWidget(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // width: size.width,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          12.ph,
          // product name and sku
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Text(
                      "18 SWG Mild Steel Binding Wire",
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  3.ph,
                  Container(
                    color: Colors.grey,
                    child: Text(
                      "wssxd-wuih",
                      style: AppTextStyles.bodyBlack14
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ),
                  3.ph,
                  Container(
                    color: Colors.grey,
                    child: Text(
                      "Price : ${Formatter.formatPrice(5000)}",
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )),
              Container(
                  color: Colors.grey, child: const Icon(CupertinoIcons.heart))
            ],
          ),
          // packaging size
          12.ph,
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Text(
                    AppStrings.packingSizeTxt,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              8.pw,
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Text(
                    "MOQ:1ton",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          8.ph,
          Wrap(
            spacing: 16.0,
            runSpacing: 8.0,
            children: sizes
                .map((size) => Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1)),
                      child: Text(
                        size.size,
                        style: AppTextStyles.bodyBlack14,
                      ),
                    ))
                .toList(),
          ),
          12.ph,
          Container(
            color: Colors.grey,
            child: Text(
              AppStrings.descriptionTxt,
              style: AppTextStyles.bodyBlack14
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          5.ph,
          Container(
            color: Colors.grey,
            height: 100,
          ),
          12.ph,
          Container(
            color: Colors.grey,
            child: Text(
              AppStrings.productDetailsTxt,
              style: AppTextStyles.bodyBlack14
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          5.ph,
          Container(
            color: Colors.grey,
            height: 200,
          ),
          20.ph,
          CustomButton(
            onPressed: () {},
            isGradient: false,
            child: Text(
              AppStrings.addToCartTxt.toUpperCase(),
              style: AppTextStyles.bodyWhite14,
            ),
          )
        ],
      ),
    );
  }
}
