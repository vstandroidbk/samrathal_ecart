import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_const.dart';
import '../../../../data/model/dashboard/dashboard_data_model.dart';
import '../../../../widgets/navigate_anim.dart';
import '../../offers/offer_details_screen.dart';

class HomeOfferListViewCard extends StatelessWidget {
  final OfferData offerData;
  final String offerImgPath;

  const HomeOfferListViewCard(
      {super.key, required this.offerData, required this.offerImgPath});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.sizeOf(context);
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
          width: mq.width * 0.8,
          placeholder: (context, url) => const SizedBox(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
