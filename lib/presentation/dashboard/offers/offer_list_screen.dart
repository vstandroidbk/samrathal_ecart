import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/offers_list_view_card.dart';

import '../../../core/app_strings.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({super.key});

  // static const String routeName = "Offer List Screen";

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offer List"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: offerList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: OfferListViewCard(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
