import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinStatistics extends StatelessWidget {
  final String lowPrice;
  final String highPrice;
  final String avgPrice;
  final String theme;

  const CoinStatistics({
    super.key,
    required this.lowPrice,
    required this.highPrice,
    required this.avgPrice,
    required this.theme
  });

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                'Coin statistics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
      
          const SizedBox(height: 5),
      
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: theme == 'light' ? const Color(0xfff7f7f7) : const Color(0xff1b2129),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'High price (24h)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
            
                Text(
                  '\$${formatter.format(double.parse(highPrice))}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
      
          const SizedBox(height: 15),
      
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: theme == 'light' ? const Color(0xfff7f7f7) : const Color(0xff1b2129),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Low price (24h)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
            
                Text(
                  '\$${formatter.format(double.parse(lowPrice))}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          
          const SizedBox(height: 15),
      
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: theme == 'light' ? const Color(0xfff7f7f7) : const Color(0xff1b2129),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Average price (24h)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
            
                Text(
                  '\$${formatter.format(double.parse(avgPrice))}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}