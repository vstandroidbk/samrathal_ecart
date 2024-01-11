import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/bank_ac_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/qr_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/upi_page.dart';
import '../../../../core/app_strings.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  // static const String routeName = "Payment Details Screen";

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: Text(AppStrings.paymentDetailsTxt)
            .animate()
            .fadeIn(duration: 500.ms),
        bottom: TabBar(
          controller: tabController,
          labelStyle: const TextStyle(color: AppColors.whiteColor),
          unselectedLabelColor: Colors.grey.shade200,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: AppStrings.bankAcTxt).animate().fadeIn(duration: 500.ms),
            Tab(text: AppStrings.upiTxt).animate().fadeIn(duration: 500.ms),
            Tab(text: AppStrings.qrTxt).animate().fadeIn(duration: 500.ms),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [BankAcPage(), UpiPage(), QrPage()],
      ),
    );
  }
}
