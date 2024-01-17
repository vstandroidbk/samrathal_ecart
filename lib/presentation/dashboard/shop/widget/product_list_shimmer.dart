import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ProductListShimmer extends StatelessWidget {
  const ProductListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey100,
      highlightColor: AppColors.grey300,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 30, // Spacing between columns
            mainAxisSpacing: 8, // Spacing between rows
            mainAxisExtent: 200),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                // width: 120,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(right: 0),
              ),
            ],
          );
        },
      ),
    );
  }
}
