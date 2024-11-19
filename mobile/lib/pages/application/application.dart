import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/pages/application/home.dart';
import 'package:btc/pages/application/profile.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationController applicationcontroller = Get.find<ApplicationController>();
    final Themecontroller themecontroller = Get.find<Themecontroller>();
    
    return Obx(() =>
      Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: PageView(
          controller: applicationcontroller.pageController,
          onPageChanged: (index) {
            applicationcontroller.hanglePageChange(index);
          },
          children: const [
            HomePage(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
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
              selectedItemColor: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
              backgroundColor: themecontroller.theme.value == 'light' ? Colors.white : Colors.black,

              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10
              ),
              unselectedIconTheme: const IconThemeData(
                size: 20
              )

              ,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              selectedIconTheme: const IconThemeData(
                size: 24
              ),
              
            ),
          ),
        )
      ),
    );
  }
}