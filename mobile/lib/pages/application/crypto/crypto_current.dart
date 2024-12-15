import 'package:btc/controllers/app/crypto_controller.dart';
import 'package:btc/routes/routes.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CryptoCurrent extends StatelessWidget {
  const CryptoCurrent({super.key});

  @override
  Widget build(BuildContext context) {

    final CryptoController cryptoController = Get.find<CryptoController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() =>
      cryptoController.noCryptoData.value ? const Center(child: Text('No crypto data')) :
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView.separated(
          itemCount: cryptoController.coinList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15), 
          itemBuilder: (context, index) {
            final item = cryptoController.coinList[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppRoutes.coinchart,
                  arguments: {
                    'symbol': item['coin_name'].split('/')[0] + item['coin_name'].split('/')[1],
                    'price': item['average_price'].toString(),
                    'percentChange': '0',
                    'name': item['coin_name'].split('/')[2],
                    'shortName': item['coin_name'].split('/')[0],
                    'faceValue': item['coin_name'].split('/')[1]
                  }
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeController.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['coin_name'].split('/')[0] + '/' + item['coin_name'].split('/')[1],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
              
                        Text(
                          item['coin_name'].split('/')[2],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
              
                    const SizedBox(height: 5),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          item['amount'].toString(),
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
              
                    const SizedBox(height: 5),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          '\$${item['average_price']}',
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
              
                    const SizedBox(height: 5),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'First time buy',
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(item['first_time_buy'])),
                          style: TextStyle(
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ]
                ),
              ),
            );
          }, 
        )
      ),
    );
  }
}