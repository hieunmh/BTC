import 'package:btc/model/coin_model.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({super.key, required this.coinitem});

  final CoinModel coinitem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xfff7f7f7),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Image.network(coinitem.image),
              ),

              const SizedBox(width: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${coinitem.symbol.toUpperCase()}/BUSD',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    coinitem.name,
                    style: const TextStyle(
                      fontSize: 12
                    ),
                  )
                ],
              )
            ],
          ),

          const SizedBox(width: 10),
          
          SizedBox(
            width: 65,
            child: Sparkline(
              data: coinitem.sparklineIn7D.price,
              lineColor: coinitem.marketCapChangePercentage24H >= 0 ? Colors.green : Colors.red,
              lineWidth: 1.5,
              fillMode: FillMode.below,
              fillGradient: LinearGradient(
                colors: coinitem.marketCapChangePercentage24H >= 0
                ? [Colors.green.shade200, Colors.green.shade50]
                : [Colors.red.shade200, Colors.red.shade50],
              ),
            ),
          ),

          const SizedBox(width: 10),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${coinitem.currentPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700
                ),
              ),
              Row(
                  children: [
                    Text(
                      coinitem.priceChange24H >= 0 ? "+${coinitem.priceChangePercentage24H.toStringAsFixed(2)}%" : 
                      "${coinitem.priceChangePercentage24H.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: coinitem.priceChangePercentage24H >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}