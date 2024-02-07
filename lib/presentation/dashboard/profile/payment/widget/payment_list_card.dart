import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_details_screen.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_strings.dart';
import '../../../../../core/app_text_styles.dart';
import '../../../../../data/model/dashboard/profile/order_payment_list_model.dart';
import '../../../../../logic/services/formatter.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/navigate_anim.dart';
import '../payment_method_screen.dart';

class PaymentListCard extends StatelessWidget {
  final int index;
  final PaymentList paymentList;

  const PaymentListCard(
      {super.key, required this.index, required this.paymentList});

  @override
  Widget build(BuildContext context) {
    // var paymentData = paymentList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.orderIdTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  // const Text(":"),
                  Expanded(
                    child: Text(
                      "#${paymentList.orderNumber!}",
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentIdTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  // const Text(":"),
                  Expanded(
                    child: paymentList.paymentMethod != null &&
                            paymentList.paymentMethod! == 1
                        ? Text(
                            "COD",
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          )
                        : Text(
                            getPaymentTypeText(
                                paymentList.paymentType!, paymentList),
                            textAlign: TextAlign.right,
                            style: AppTextStyles.bodyBlack14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentDateTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  // const Text(":"),
                  Expanded(
                    child: Text(
                      Formatter.formatDateWithTime(
                          DateTime.parse(paymentList.paymentDate!)),
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.paymentStatusTxt,
                      style: AppTextStyles.bodyBlack14
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  // const Text(":"),
                  Expanded(
                    child: Text(
                      // getStatus(paymentList.orderStatus!),
                      paymentList.paymentStatus != null &&
                              paymentList.paymentStatus! == 0
                          ? "Pending"
                          : "Approved",
                      textAlign: TextAlign.right,
                      style: AppTextStyles.bodyBlack14.copyWith(
                          color: paymentList.paymentStatus != null &&
                                  paymentList.paymentStatus! == 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              5.ph,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    AppStrings.paymentAmtTxt,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
                  // const Text(":"),
                  Expanded(
                      child: Text(
                    Formatter.formatPrice(
                      num.parse(
                        paymentList.payAmount!,
                      ),
                    ),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodyBlack14
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
                ],
              ),
              5.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  paymentList.paymentStatus != null &&
                          paymentList.paymentStatus! == 0
                      ? CustomButton(
                          width: 100,
                          height: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadeAnimatingRoute(
                                route: PaymentMethodScreen(
                                  screenType: AppStrings.fromPaymentList,
                                  orderId: paymentList.orderId,
                                  orderToken: paymentList.orderToken,
                                ),
                              ),
                            );
                          },
                          isGradient: false,
                          backgroundColor: AppColors.greenBtnColor,
                          child: Text(
                            AppStrings.payNowTxt.toUpperCase(),
                            style: AppTextStyles.bodyWhite12,
                          ),
                        )
                      : const SizedBox(),
                  if (paymentList.paymentMethod != null &&
                      paymentList.paymentMethod! == 0)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeAnimatingRoute(
                            route: PaymentDetailsScreen(
                              orderPaymentId: paymentList.id!,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.eye_solid,
                        color: AppColors.lightGrey,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
