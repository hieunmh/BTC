import 'package:btc/controllers/app/market_controller.dart';
import 'package:btc/pages/application/market/coin_item.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {

    final MarketController marketcontroller = Get.put(MarketController());
    final ThemeController themecontroller = Get.find<ThemeController>();

    return Obx(() =>
      Scaffold(
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          toolbarHeight: 0.0,
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: TextField(
                    autofocus: false,
                    onChanged: (value) {
                      marketcontroller.filterCoinsFaceValue();
                    },
                    controller: marketcontroller.filterSearch,
                    cursorColor: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
                    style: TextStyle(
                      color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
                    ),
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      icon: Icon(
                        FontAwesome.magnifying_glass_dollar_solid,
                        color: Color(0xfffbc700),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 10),
    
              SizedBox(
                height: 30,
                child: ListView.separated(
                  controller: marketcontroller.faceValueScrollController,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 10), 
                  itemCount: marketcontroller.faceValueList.length,
                  itemBuilder: (context, index) {
                    final item = marketcontroller.faceValueList[index];
                    return GestureDetector(
                      onTap: () {
                        marketcontroller.defaultFaceValue.value = item;
                        marketcontroller.filterCoinsFaceValue();
                        marketcontroller.scrollToCurrentFaceValue();
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: marketcontroller.defaultFaceValue.value == item ? const Color(0xfffbc700) : Colors.transparent,
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
                              color: marketcontroller.defaultFaceValue.value == item ? Colors.white : const Color(0xfffbc700),
                              fontWeight: marketcontroller.defaultFaceValue.value == item ? FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    );
                  }
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
                  itemCount: marketcontroller.filterCoinList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = marketcontroller.filterCoinList[index];
                    return CoinItem(
                      item: item, 
                      faceValue: marketcontroller.defaultFaceValue.value,
                      theme: themecontroller.theme.value,
                    );
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