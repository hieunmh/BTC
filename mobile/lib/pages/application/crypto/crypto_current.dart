import 'package:btc/controllers/app/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoCurrent extends StatelessWidget {
  const CryptoCurrent({super.key});

  @override
  Widget build(BuildContext context) {

    final CryptoController cryptoController = Get.find<CryptoController>();

    return Obx(() =>
      Container(
        child: ListView.separated(
          itemCount: cryptoController.coinList.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10), 
          itemBuilder: (context, index) {
            return Container(
              
            );
          }, 
        )
      ),
    );
  }
}