import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinFacevalue extends StatelessWidget {
  final List<String> timeFramesList;
  final String timeFrame;
  final Function getCoinPrices;
  final Function(String) setTimeFrame;

  const CoinFacevalue({
    super.key,
    required this.timeFramesList,
    required this.timeFrame, 
    required this.getCoinPrices,
    required this.setTimeFrame
  });

  @override
  Widget build(BuildContext context) {
   return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 30,
      child: ListView.separated(
        itemCount: timeFramesList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10), 
        itemBuilder: (context, index) {
          final item = timeFramesList[index];
          return GestureDetector(
            onTap: () {
              setTimeFrame(item);
              getCoinPrices();
            },
            child: Container(
              width: (Get.width) / 5,
              decoration: BoxDecoration(
                color: timeFrame == item ? const Color(0xfffbc700) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xfffbc700),
                  width: 1
                )
              ),
              child: Center(
                child: Text(
                  item,
                  style: TextStyle(
                    color: timeFrame == item ? Colors.white : const Color(0xfffbc700),
                    fontWeight:timeFrame == item ? FontWeight.bold : FontWeight.normal
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}