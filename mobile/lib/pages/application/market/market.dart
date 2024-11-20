import 'package:btc/controllers/app/market_controller.dart';
import 'package:btc/pages/application/market/coin_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {

    final MarketController marketcontroller = Get.find<MarketController>();

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: const Color(0xfff6f6f6),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Obx(() =>
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      suffixIcon: Icon(
                        Iconsax.search_normal_1_outline,
                        color: Color(0xfffbc700),
                        size: 20,
                      )
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 10),
          
              Expanded(
                child: ListView.separated(
                  itemCount: marketcontroller.coinList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = marketcontroller.coinList[index];
                    return CoinItem(coinitem: item);
                  }
                )
              )
          
            ],
          ),
        ),
      )
    );
  }
}