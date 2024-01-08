import 'package:flutter/cupertino.dart';
import 'package:samrathal_ecart/presentation/auth/forgot_pass_otp_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/forgot_password_screen.dart';
import 'package:samrathal_ecart/presentation/auth/login_otp_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/mobile_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/new_password_screen.dart';
import 'package:samrathal_ecart/presentation/auth/password_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/register_company_screen.dart';
import 'package:samrathal_ecart/presentation/auth/submit_user_details.dart';
import 'package:samrathal_ecart/presentation/auth/register_otp_verify_screen.dart';
import 'package:samrathal_ecart/presentation/auth/register_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/dashboard_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/home/widgets/offers_list_view_card.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/add_address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/address/edit_address_page.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_details_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_items_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/order_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/order/widget/order_success_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_details_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/payment_list_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/profile/payment/widget/payment_success_screen.dart';
import 'package:samrathal_ecart/presentation/dashboard/shop/product_details_screen.dart';
import 'package:samrathal_ecart/presentation/verify_otp_screen.dart';
import '../presentation/dashboard/cart/select_address_page.dart';
import '../presentation/dashboard/offers/offer_details_screen.dart';
import '../presentation/dashboard/offers/offer_list_screen.dart';
import '../presentation/splash_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case MobileVerifyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const MobileVerifyScreen(),
        );

      case PasswordVerifyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PasswordVerifyScreen(),
        );

      case LoginOtpVerifyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const LoginOtpVerifyScreen(),
        );

      case ForgotPasswordScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case ForgotPassOtpVerifyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ForgotPassOtpVerifyScreen(),
        );

      case NewPasswordScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const NewPasswordScreen(),
        );

      case RegisterOtpVerifyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const RegisterOtpVerifyScreen(),
        );

      case RegisterScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const RegisterScreen(),
        );

      case SubmitUserDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SubmitUserDetailsScreen(),
        );

      case RegisterCompanyScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const RegisterCompanyScreen(),
        );

      case VerifyOtpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) =>
              VerifyOtpScreen(fromScreen: settings.arguments as String),
        );

      case DashboardScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => DashboardScreen(
            selectedTab: settings.arguments as int,
          ),
        );

      case AddressPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const AddressPage(),
        );

      case AddAddressPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const AddAddressPage(),
        );

      case EditAddressPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditAddressPage(),
        );

      case OrderScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OrderScreen(),
        );

      case OrderDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => OrderDetailsScreen(
            orderNumber: settings.arguments as int,
          ),
        );

      case OrderItemsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OrderItemsScreen(),
        );

      case OrderSuccessScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => OrderSuccessScreen(),
        );

      case PaymentListScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PaymentListScreen(),
        );

      case PaymentDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PaymentDetailsScreen(),
        );

      case PaymentSuccessScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const PaymentSuccessScreen(),
        );

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ProductDetailsScreen(),
        );

      case OfferDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OfferDetailsScreen(),
        );

      case OfferListScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const OfferListScreen(),
        );

      case SelectAddressPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SelectAddressPage(),
        );
      // case DataManageListScreen.routeName:
      //   return CupertinoPageRoute(
      //     builder: (context) => DataManageListScreen(
      //       batchNo: settings.arguments as int,
      //     ),
      //   );
    }
    return null;
  }
}
