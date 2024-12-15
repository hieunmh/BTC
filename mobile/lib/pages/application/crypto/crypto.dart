import 'package:btc/pages/application/crypto/crypto_current.dart';
import 'package:btc/pages/application/crypto/history.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoPage extends StatelessWidget {
  const CryptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themecontroller = Get.find<ThemeController>();

    return DefaultTabController(
      length: 2,
      child: Obx(() =>
        Scaffold(
          backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
          appBar: AppBar(
            backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
            toolbarHeight: 0.0,
            scrolledUnderElevation: 0.0,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Cryptocurrency'),
                Tab(text: 'History'),
              ],
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: const  WidgetStatePropertyAll(Colors.transparent),
              unselectedLabelColor: Colors.grey,
              labelColor: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
              indicatorColor: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
            ),
          ),
          body: const TabBarView(
            children: [
              CryptoCurrent(),
              History(),
            ]
          )
        ),
      ),
    );
  }
}