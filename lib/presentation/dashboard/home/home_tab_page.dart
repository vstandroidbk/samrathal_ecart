import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/core/app_strings.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/dashboard/dashboard_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/home_label_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/offers_list_view_card.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/product_list_widget.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/slider_widget.dart';
import 'package:samrathal_ecart/utils/utils.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        titleSpacing: 12,
        title: Row(
          children: [
            Text(AppStrings.appName),
            16.pw,
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  DashboardScreen.routeName,
                  arguments: 2,
                  (route) => false);
            },
            child: Badge(
              label: Text(
                "12",
                style: AppTextStyles.bodyBlack12,
              ),
              backgroundColor: Colors.white,
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
            ),
          ),
          16.pw,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            const SliderWidget(),
            12.ph,
            HomeLabelWidget(labelName: AppStrings.offersTxt),
            5.ph,
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                itemCount: offerList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: OfferListViewCard(
                      index: index,
                    ),
                  );
                },
              ),
            ),
            12.ph,
            HomeLabelWidget(labelName: AppStrings.productsTxt),
            5.ph,
            const SizedBox(
              height: 220,
              width: double.infinity,
              child: ProductListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
