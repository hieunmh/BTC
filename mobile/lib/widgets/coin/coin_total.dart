import 'package:flutter/material.dart';

class CoinTotal extends StatelessWidget {
  final String theme;
  final String faceValue;
  const CoinTotal({super.key, required this.theme, required this.faceValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1f2630),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child: Text(
          'Total($faceValue)',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}