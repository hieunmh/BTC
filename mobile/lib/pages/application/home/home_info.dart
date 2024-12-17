import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeInfo extends StatelessWidget {
  final String userEmail;
  final double userMoney; 

  const HomeInfo({
    super.key,
    required this.userEmail,
    required this.userMoney
  });

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/user-placeholder.png', 
                    width: 50, 
                    height: 50, 
                    fit: BoxFit.cover
                  ),
                ),
  
                const SizedBox(width: 10),
  
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  ],
                )
              ],
            ),
  
            const Icon(
              Iconsax.notification_outline,
              size: 24,
            )
          ],
        ),
  
        const SizedBox(height: 15),
  
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xfffbc700),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Total balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  Text(
                    '\$${formatter.format(double.parse(userMoney.toString()))}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        userMoney <= 500000 ? FontAwesome.arrow_trend_down_solid :
                        FontAwesome.arrow_trend_up_solid,
                        color: const Color(0xfffbc700),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${((1- userMoney / 500000) * 100).toStringAsFixed(2)}%',
                        style: const TextStyle(
                          color: Color(0xfffbc700),
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}