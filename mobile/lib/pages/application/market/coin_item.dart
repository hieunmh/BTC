import 'package:btc/model/coin.dart';
import 'package:btc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class CoinItem extends StatelessWidget {
  final Coin item;
  final String faceValue;
  final String theme;

  const CoinItem({
    super.key, 
    required this.item, 
    required this.faceValue,
    required this.theme
  });

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0.00", "en_US");

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.coinchart,
          arguments: {
            'symbol': item.symbol,
            'price': item.price,
            'percentChange': item.percentChange,
            'name': item.name,
            'shortName': item.shortName,
            'faceValue': faceValue
          }
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme == 'light' ? Colors.white : const Color(0xff1f2630),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.shortName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 0
                      ),
                    ),
                    Text(
                      ' /$faceValue',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
                Text(
                  item.name
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${formatter.format(double.parse(item.price))}',
                  style: TextStyle(
                    color: theme == 'light' ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      double.parse(item.percentChange ?? '0.0') >= 0 ? Iconsax.arrow_up_1_bold : Iconsax.arrow_down_bold,
                      color: double.parse(item.percentChange ?? '0.0') >= 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                      size: 20,
                    ),
                    Text(
                      '${formatter.format(double.parse(item.percentChange ?? '0.0').abs())}%',
                      style: TextStyle(
                        color: double.parse(item.percentChange ?? '0.0') >= 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }
}