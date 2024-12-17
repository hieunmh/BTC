import 'package:btc/controllers/app/crypto_controller.dart';
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
    final CryptoController cryptocontroller = Get.find<CryptoController>();

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
          body: TabBarView(
            children: [
              CryptoCurrent(
                coinList: cryptocontroller.coinList,
                theme: themecontroller.theme.value,
                noCryptoData: cryptocontroller.noCryptoData.value,
              ),
              History(
                coinTransHistory: cryptocontroller.coinTransHistory,
                theme: themecontroller.theme.value,
                noHistoryData: cryptocontroller.noHistoryData.value,
              ),
            ]
          )
        ),
      ),
    );
  }
}