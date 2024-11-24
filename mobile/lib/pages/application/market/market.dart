import 'package:btc/controllers/app/market_controller.dart';
import 'package:btc/pages/application/market/coin_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {

    final MarketController marketcontroller = Get.put(MarketController());

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: const Color(0xfff6f6f6),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Obx(() =>
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: TextField(
                    onChanged: (value) {
                      marketcontroller.filterCoins(value);
                    },
                    controller: marketcontroller.filterSearch,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      color: Colors.black
                    ),
                    obscureText: false,
                    decoration: const InputDecoration(
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
          
              marketcontroller.isLoading.value ? 
              const Expanded(
                child: Center(
                  child: Text('Loading...'),
                )
                ) : Expanded(
                child: marketcontroller.noData.value ? 
                const Center(
                  child: Text('No coins found'),
                ) : ListView.separated(
                  itemCount: marketcontroller.filterList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = marketcontroller.filterList[index];
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