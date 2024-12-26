import 'package:btc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CryptoCurrent extends StatelessWidget {
  final List<dynamic> coinList;
  final String theme;
  final bool noCryptoData;

  const CryptoCurrent({
    super.key,
    required this.coinList,
    required this.theme,
    required this.noCryptoData
  });

  @override
  Widget build(BuildContext context) {

    return noCryptoData ? const Center(child: Text('No crypto data')) :
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ListView.separated(
        itemCount: coinList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15), 
        itemBuilder: (context, index) {
          final item = coinList[index];

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
                color: theme == 'light' ? Colors.white : const Color(0xff1f2630),
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
                          color: theme == 'light' ? Colors.black : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        item['amount'].toStringAsFixed(5),
                        style: TextStyle(
                          color: theme == 'light' ? Colors.black : Colors.white,
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
                          color: theme == 'light' ? Colors.black : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        '\$${item['average_price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: theme == 'light' ? Colors.black : Colors.white,
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
                      const Text(
                        'First time buy',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(item['first_time_buy'])),
                        style: TextStyle(
                          color: theme == 'light' ? Colors.black : Colors.white,
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
    );
  }
}