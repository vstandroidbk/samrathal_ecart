import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/dashboard/offers/offer_details_screen.dart';

import '../../../../core/api_const.dart';
import '../../../../data/model/dashboard/dashboard_data_model.dart';

class HomeOfferListViewCard extends StatelessWidget {
  final OfferData offerData;
  final String offerImgPath;

  const HomeOfferListViewCard(
      {super.key, required this.offerData, required this.offerImgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfferDetailsScreen(
              offerId: offerData.id!,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: ApiEndPoints.baseUrl + offerImgPath + offerData.offerImage!,
          fit: BoxFit.fill,
          placeholder: (context, url) => const SizedBox(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
