import 'package:btc/controllers/app/market_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';


class ApplicationController extends GetxController {
    
  final RxString theme = 'dark'.obs;
  late final PageController pageController;
  final RxInt currentPage = 0.obs;
  final RxBool isAnimate = false.obs;

  final bottomNavBar = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Iconsax.home_2_outline),
      activeIcon: Icon(Iconsax.home_2_bold),
    ),
    BottomNavigationBarItem(
      label: 'Market',
      icon: Icon(Iconsax.bag_2_outline),
      activeIcon: Icon(Iconsax.bag_2_bold),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(Iconsax.user_octagon_outline),
      activeIcon: Icon(Iconsax.user_octagon_bold)
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void toggleTheme() {
    theme.value = theme.value == 'light' ? 'dark' : 'light';
  }

  void handlePageChange(int index) {
    if (!isAnimate.value) {
      currentPage.value = index;
    }
    if (index != 1) {
      Get.delete<MarketController>(force: true);
    }
  }

  void handleNavbarChange(int index) {
    isAnimate.value = true;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ).then((_) {
      isAnimate.value = false;
    });
    currentPage.value = index;
  }
}