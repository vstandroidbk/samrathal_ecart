import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samrathal_ecart/utils/app_utils.dart';
import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import 'cart/cart_tab_page.dart';
import 'home/home_tab_page.dart';
import 'profile/profile_tab_page.dart';
import 'shop/shop_tab_page.dart';
import 'wishlist/wishlist_tab_page.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedTab;

  const DashboardScreen({super.key, required this.selectedTab});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _backButtonCount = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeTabPage(),
    const ShopTabPage(),
    const CartTabPage(),
    const WishlistTabPage(),
    const ProfileTabPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool onBackPressed() {
    if (_selectedIndex != 0) {
      _backButtonCount = 0;
      _onItemTapped(0);
      return false;
    } else {
      if (_backButtonCount == 1) {
        return true;
      } else {
        Utils.showToast("Press back again to exit");
        _backButtonCount += 1;
        return false;
      }
    }
  }

  @override
  void initState() {
    _selectedIndex = widget.selectedTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onBackPressed();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.selectedTabColor,
          unselectedItemColor: AppColors.unSelectedTabColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: AppStrings.homeTabTxt,
              activeIcon: const Icon(
                Icons.home,
                color: AppColors.selectedTabColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_bag_outlined),
              activeIcon: const Icon(
                Icons.shopping_bag,
                color: AppColors.selectedTabColor,
              ),
              label: AppStrings.shopTabTxt,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.cart),
              activeIcon: const Icon(
                CupertinoIcons.cart_fill,
                color: AppColors.selectedTabColor,
              ),
              label: AppStrings.cartTabTxt,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.heart),
              activeIcon: const Icon(
                CupertinoIcons.heart_fill,
                color: AppColors.selectedTabColor,
              ),
              label: AppStrings.wishlistTabTxt,
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.person),
              label: AppStrings.profileTabTxt,
              activeIcon: const Icon(
                Icons.person,
                color: AppColors.selectedTabColor,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
