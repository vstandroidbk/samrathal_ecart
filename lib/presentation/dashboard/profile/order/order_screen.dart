import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_images.dart';
import 'package:samrathal_ecart/core/app_text_styles.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_view_card.dart';
import 'package:samrathal_ecart/utils/utils.dart';
import '../../../../core/app_strings.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  // static const String routeName = "Order Screen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String dropdownValue = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(AppStrings.orderTxt).animate().fadeIn(
              duration: 500.ms,
            ),
        actions: [
          Container(
            height: 35,
            width: 150,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  isDense: true,
                  style: AppTextStyles.bodyBlack14,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Image.asset(
                      AppImages.filterImg,
                      height: 18,
                      width: 18,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (onChangedValue) async {
                    setState(() {
                      dropdownValue = onChangedValue!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return dropDownList.map((value) {
                      return Center(
                        child: Text(
                          value["status"],
                          style: AppTextStyles.bodyWhite14,
                        ),
                      );
                    }).toList();
                  },
                  items: dropDownList.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item["id"].toString(),
                        child: Text(
                          item["status"].toString(),
                          style: AppTextStyles.bodyBlack14,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ).animate().fadeIn(
                duration: 500.ms,
              ),
          12.pw
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
        child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (ctx, index) {
                  return OrderViewCard(index: index);
                }).animate().slideY(
              duration: 500.ms,
            ),
      ),
    );
  }
}
