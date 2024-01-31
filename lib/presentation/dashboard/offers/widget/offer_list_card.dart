import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_const.dart';
import '../../../../data/model/dashboard/home/offer_list_model.dart';
import '../../../../widgets/navigate_anim.dart';
import '../offer_details_screen.dart';

class OfferListCard extends StatelessWidget {
  final OfferListData offerData;
  final String offerImgPath;

  const OfferListCard(
      {super.key, required this.offerData, required this.offerImgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          FadeAnimatingRoute(
            route: OfferDetailsScreen(
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
