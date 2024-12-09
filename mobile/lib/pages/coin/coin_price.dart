import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:icons_plus/icons_plus.dart';

class CoinPrice extends StatelessWidget {
  final String trackballPrice;
  final String percentChange;


  const CoinPrice({
    super.key,
    required this.trackballPrice,
    required this.percentChange
  });

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Center(
      child: Column(
        children: [
          Text(
            '\$${formatter.format(double.parse(trackballPrice))}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: double.parse(percentChange) > 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                double.parse(percentChange) >= 0 ? Iconsax.arrow_up_1_bold : Iconsax.arrow_down_bold,
                color: double.parse(percentChange) >= 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                size: 20,
              ),

              Text(
                '${formatter.format(double.parse(percentChange).abs())}%',
                style: TextStyle(
                  color: double.parse(percentChange) > 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                  fontWeight: FontWeight.w500,
                  fontSize: 20
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}