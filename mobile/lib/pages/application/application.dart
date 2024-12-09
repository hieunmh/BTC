import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/pages/application/home/home.dart';
import 'package:btc/pages/application/market/market.dart';
import 'package:btc/pages/application/profile/profile.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationController applicationcontroller = Get.find<ApplicationController>();
    final ThemeController themecontroller = Get.find<ThemeController>();
    
    return Obx(() =>
      Scaffold(
        body: PageView(
          controller: applicationcontroller.pageController,
          onPageChanged: (index) {
            applicationcontroller.handlePageChange(index);
          },
          children: const [
            HomePage(),
            MarketPage(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: themecontroller.theme.value == 'dark' ? Colors.grey : const Color(0xffd1d1d1),
                width: 0.5
              )
            )
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: applicationcontroller.bottomNavBar,
              currentIndex: applicationcontroller.currentPage.value,
              onTap: applicationcontroller.handleNavbarChange,
              selectedItemColor: const Color(0xfffbc700),
              backgroundColor: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
              unselectedItemColor: themecontroller.theme.value == 'light' ? const Color(0xff1f2630) : Colors.white,

              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10
              ),
              unselectedIconTheme: const IconThemeData(
                size: 20
              ),

              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10
              ),
              selectedIconTheme: const IconThemeData(
                size: 20
              ),
              
            ),
          ),
        )
      ),
    );
  }
}