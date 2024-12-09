import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApplicationController extends GetxController {
    
  final RxString theme = 'dark'.obs;
  late final PageController pageController;
  final RxInt currentPage = 0.obs;
  final RxBool isAnimate = false.obs;
  final RxString userId = ''.obs;
  final RxString userEmail = ''.obs;
  final RxDouble userMoney = 0.0.obs;

  final supabase = Supabase.instance.client;

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
    if (userId.value.isEmpty) {
      getUserInfo();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> getUserInfo() async {
    final res = await supabase.from('Users').select().eq('id', supabase.auth.currentUser!.id).single();
    userId.value = res['id'].toString();
    userEmail.value = res['email'].toString();
    userMoney.value = res['money'].toDouble();
  }


  void handlePageChange(int index) {
    if (!isAnimate.value) {
      currentPage.value = index;
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