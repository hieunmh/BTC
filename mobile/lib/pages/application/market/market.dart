import 'package:btc/controllers/app/market_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {

    final MarketController marketcontroller = Get.put(MarketController());

    final formatter = NumberFormat("#,##0.00", "en_US");

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
                      marketcontroller.filterCoinsFaceValue();
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

              SizedBox(
                height: 30,
                child: ListView.separated(
                  controller: marketcontroller.faceValueScrollController,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 10), 
                  itemCount: marketcontroller.faceValueList.length,
                  itemBuilder: (context, index) {
                    final item = marketcontroller.faceValueList[index];
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: marketcontroller.defaultFaceValue.value == item ? const Color(0xfffbc700) : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: const Color(0xfffbc700),
                          width: 1
                        )
                      ),
                      child: GestureDetector(
                        onTap: () {
                          marketcontroller.defaultFaceValue.value = item;
                          marketcontroller.filterCoinsFaceValue();
                          marketcontroller.scrollToCurrentFaceValue();
                        },
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
                                    ' /${marketcontroller.defaultFaceValue.value}',
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
                              Text(
                                double.parse(item.percentChange ?? '0.0') >= 0 ?
                                '+${formatter.format(double.parse(item.percentChange ?? '0.0'))}%' : '${formatter.format(double.parse(item.percentChange ?? '0.0'))}%',
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