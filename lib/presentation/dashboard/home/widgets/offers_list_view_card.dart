import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/presentation/dashboard/offers/offer_details_screen.dart';

class OfferListViewCard extends StatelessWidget {
  final int index;

  const OfferListViewCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, OfferDetailsScreen.routeName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          offerList[index],
          fit: BoxFit.fill,
          height: 150,
        ),
      ),
    );
  }
}
