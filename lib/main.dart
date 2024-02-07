import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/order_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/payment_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/wishlist/wishlist_api_provider.dart';
import 'core/app_colors.dart';
import 'core/app_theme.dart';
import 'logic/provider/auth/auth_api_provider.dart';
import 'logic/provider/dashboard/cart/cart_api_provider.dart';
import 'logic/provider/dashboard/cart/update_cart_calculator_provider.dart';
import 'logic/provider/dashboard/dashboard_api_provider.dart';
import 'logic/provider/dashboard/home/home_api_provider.dart';
import 'logic/provider/dashboard/profile/address/address_api_provider.dart';
import 'logic/provider/dashboard/profile/address/location_data_provider.dart';
import 'logic/provider/dashboard/shop/add_cart_calculator_provider.dart';
import 'logic/provider/dashboard/shop/shop_api_provider.dart';
import 'presentation/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: AppColors.primaryColor,
    //status bar brightness
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => AuthApiProvider()),
        ChangeNotifierProvider(create: (_) => AddressApiProvider()),
        ChangeNotifierProvider(create: (_) => DashboardApiProvider()),
        ChangeNotifierProvider(create: (_) => ShopApiProvider()),
        ChangeNotifierProvider(create: (_) => HomeApiProvider()),
        ChangeNotifierProvider(create: (_) => AddCartCalculatorProvider()),
        ChangeNotifierProvider(create: (_) => UpdateCartCalculatorProvider()),
        ChangeNotifierProvider(create: (_) => CartApiProvider()),
        ChangeNotifierProvider(create: (_) => PaymentApiProvider()),
        ChangeNotifierProvider(create: (_) => OrderApiProvider()),
        ChangeNotifierProvider(create: (_) => WishlistApiProvider()),
      ],
      child: MaterialApp(
        title: 'Samrathal E-cart',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        home: const SplashScreen(),
        // onGenerateRoute: Routes.onGenerateRoute,
        // initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
