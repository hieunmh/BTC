import 'package:btc/controllers/app/crypto_controller.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {

    final CryptoController cryptoController = Get.find<CryptoController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ListView.separated(
        itemCount: cryptoController.coinTransHistory.length ,
        itemBuilder: (context, index) => const SizedBox(height: 15), 
        separatorBuilder: (context, index) {
          final item = cryptoController.coinTransHistory[index];

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeController.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          item['']
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }, 
      )
    );
  }
}