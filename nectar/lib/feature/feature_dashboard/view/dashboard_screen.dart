import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nectar/constant/constant.dart';
import 'package:nectar/feature/feature_dashboard/controller/dashboard_controller.dart';
import 'package:nectar/feature/feature_cart/view/cart_screen.dart';
import 'package:nectar/feature/feature_explore/view/explore_screen.dart';
import 'package:nectar/feature/feature_favourite/view/favourite_screen.dart';
import 'package:nectar/feature/feature_profile/view/profile_screen.dart';
import 'package:nectar/feature/feature_shop/view/shop_screen.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/image_constant.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(
      init: DashboardController(),
      builder: (dashboardController) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: dashboardController.tabIndex.value,
              children: [
                ShopScreen(),
                ExploreScreen(),
                CartScreen(),
                FavouriteScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ColorStyles.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorStyles.primaryColor,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedItemColor: Colors.black,
            onTap: dashboardController.changeTabIndex,
            currentIndex: dashboardController.tabIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(kShopImage,
                    color: dashboardController.tabIndex.value == 0
                    ? ColorStyles.primaryColor
                    : ColorStyles.black),
                label: kShop,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(kExploreImage,
                    color: dashboardController.tabIndex.value == 1
                        ? ColorStyles.primaryColor
                        : ColorStyles.black),
                label: kExplore,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(kCartImage,
                  color: dashboardController.tabIndex.value == 2
                      ? ColorStyles.primaryColor
                      : ColorStyles.black),
                label: kCart,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(kFavouriteImage,
                    color: dashboardController.tabIndex.value == 3
                        ? ColorStyles.primaryColor
                        : ColorStyles.black),
                label: kFavourite,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(kAccountImage,
                    color: dashboardController.tabIndex.value == 4
                        ? ColorStyles.primaryColor
                        : ColorStyles.black),
                label: kAccount,
              ),
            ],
          ),
        );
      }
    );
  }
}
