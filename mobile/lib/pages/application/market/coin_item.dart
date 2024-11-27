import 'package:btc/model/coin.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class CoinItem extends StatelessWidget {
  final Coin item;
  final String faceValue;

  const CoinItem({super.key, required this.item, required this.faceValue});

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
                      fontWeight: FontWeight.bold
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
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
              Row(
                children: [
                  Icon(
                    double.parse(item.percentChange ?? '0.0') >= 0 ? Iconsax.arrow_up_1_bold : Iconsax.arrow_down_bold,
                    color: double.parse(item.percentChange ?? '0.0') >= 0 ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  Text(
                    '${formatter.format(double.parse(item.percentChange ?? '0.0').abs())}%',
                    style: TextStyle(
                      color: double.parse(item.percentChange ?? '0.0') >= 0 ? Colors.green : Colors.red,
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
    );
  }
}