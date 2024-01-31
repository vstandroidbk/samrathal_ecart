import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/payment_api_provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import 'bank_ac_page.dart';
import 'qr_page.dart';
import 'upi_page.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String screenType;
  final String? addressId;
  final String? orderId;
  final String? orderToken;

  const PaymentMethodScreen(
      {super.key,
      required this.screenType,
      this.addressId,
      this.orderId,
      this.orderToken});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    callApi();
  }

  Future<void> callApi() async {
    var addressProvider =
        Provider.of<PaymentApiProvider>(context, listen: false);
    addressProvider.setPaymentMethodListNull();
    await addressProvider.getPaymentMethodListApi(
        screenType: widget.screenType, orderId: widget.orderId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: Text(/*AppStrings.paymentDetailsTxt*/
            AppStrings.paymentMethodTxt).animate().fadeIn(duration: 500.ms),
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
      body: Consumer<PaymentApiProvider>(
        builder: (BuildContext context, PaymentApiProvider paymentProvider,
            Widget? child) {
          return paymentProvider.paymentMethodListLoading
              ? const SpinKitCircle(
                  color: AppColors.primaryColor,
                )
              : TabBarView(
                  controller: tabController,
                  children: [
                    BankAcPage(
                      screenType: widget.screenType,
                      addressId: widget.addressId,
                      orderId: widget.orderId,
                      orderToken: widget.orderToken,
                    ),
                    UpiPage(
                      screenType: widget.screenType,
                      addressId: widget.addressId,
                      orderId: widget.orderId,
                      orderToken: widget.orderToken,
                    ),
                    QrPage(
                      screenType: widget.screenType,
                      addressId: widget.addressId,
                      orderId: widget.orderId,
                      orderToken: widget.orderToken,
                    )
                  ],
                );
        },
      ),
    );
  }
}
