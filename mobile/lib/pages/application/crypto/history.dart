import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  final List<dynamic> coinTransHistory;
  final String theme;
  const History({
    super.key,
    required this.coinTransHistory,
    required this.theme
  });

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.find<ThemeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ListView.separated(
        itemCount: coinTransHistory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15), 
        itemBuilder: (context, index) {
          final item = coinTransHistory[index];
    
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeController.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item['coin_name'].split('/')[0] + '/' + item['coin_name'].split('/')[1],
                      style: TextStyle(
                        color: theme == 'light' ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),

                    Text(
                      item['coin_name'].split('/')[2],
                      style: TextStyle(
                        color: item['type_order'] == 'Buy' ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    ),

                    Text(
                      item['amount'].toString(),
                      style: TextStyle(
                        color: theme == 'light' ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 5), 

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    ),

                    Text(
                      '\$${item['price']}',
                      style: TextStyle(
                        color: theme == 'light' ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item['type_order'] + ' date',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    ),

                    Text(
                      DateFormat('HH:mm dd/MM/yyyy').format(DateTime.parse(item['created_at'])),
                      style: TextStyle(
                        color: theme == 'light' ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
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