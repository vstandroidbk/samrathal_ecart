import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class OfferListShimmer extends StatelessWidget {
  const OfferListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 15,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.grey100,
          highlightColor: AppColors.grey300,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
