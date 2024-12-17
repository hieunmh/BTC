import 'package:btc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCoinWatchlist extends StatelessWidget {
  final List<dynamic> coinWatchList;
  final String theme;
  
  const HomeCoinWatchlist({
    super.key,
    required this.theme,
    required this.coinWatchList
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10), 
        itemCount: coinWatchList.length,
        itemBuilder: (context, index) {
          final item = coinWatchList[index];

          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.coinchart, 
                arguments: {
                  'symbol': item['coin_name'].split('/')[0] + item['coin_name'].split('/')[1],
                  'price': '0',
                  'percentChange': '0',
                  'name': item['full_name'],
                  'shortName': item['coin_name'].split('/')[0],
                  'faceValue': item['coin_name'].split('/')[1]
                }
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 150,
              decoration: BoxDecoration(
                color: theme == 'light' ? Colors.white : const Color(0xff1f2630),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['coin_name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    item['full_name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}