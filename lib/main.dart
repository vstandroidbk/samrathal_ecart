import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samrathal_ecart/core/app_colors.dart';
import 'package:samrathal_ecart/logic/provider/auth/auth_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/cart/cart_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/home/home_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/address/address_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/profile/address/location_data_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/dashboard_api_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/shop/add_cart_calculator_provider.dart';
import 'package:samrathal_ecart/logic/provider/dashboard/shop/shop_api_provider.dart';
import 'package:samrathal_ecart/presentation/splash_screen.dart';
import 'core/app_theme.dart';

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
        ChangeNotifierProvider(create: (_) => CartApiProvider()),
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
