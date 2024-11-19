import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
    
  final RxString theme = 'dark'.obs;
  late final PageController pageController;
  final RxInt currentPage = 0.obs;

  final bottomNavBar = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(CupertinoIcons.house)
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(CupertinoIcons.person_fill)
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

  void hanglePageChange(int index) {
    currentPage.value = index;
  }

  void handleNavbarChange(int index) {
    currentPage.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}