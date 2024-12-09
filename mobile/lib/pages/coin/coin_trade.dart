import 'package:btc/controllers/coin/coinchart_controller.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:btc/widgets/coin/coin_total.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoinTrade extends StatelessWidget {
  const CoinTrade({super.key});

  @override
  Widget build(BuildContext context) {

    final CoinchartController coinchartcontroller = Get.find<CoinchartController>();
    final ThemeController themeController = Get.find<ThemeController>();

    final formatter = NumberFormat("#,##0.00", "en_US");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Obx(() =>
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      coinchartcontroller.tradeType.value = 'Buy';
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 100)/2,
                      height: 30,
                      decoration: BoxDecoration(
                        color: coinchartcontroller.tradeType.value == 'Buy' ? const Color(0xff1bb455) : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)
                        ),
                        border: Border(
                          top: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Buy' ? const Color(0xff1bb455) : Colors.grey,
                            width: 1
                          ),
                          left: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Buy' ? const Color(0xff1bb455) : Colors.grey,
                            width: 1
                          ),
                          bottom: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Buy' ? const Color(0xff1bb455) : Colors.grey,
                            width: 1
                          ),
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Buy',
                          style: TextStyle(
                            color: coinchartcontroller.tradeType.value == 'Buy' ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      coinchartcontroller.tradeType.value = 'Sell';
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 100)/2,
                      height: 30,
                      decoration: BoxDecoration(
                        color: coinchartcontroller.tradeType.value == 'Sell' ? const Color(0xffd23c3f) : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)
                        ),
                        border: Border(
                          top: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Sell' ? const Color(0xffd23c3f) : Colors.grey,
                            width: 1
                          ),
                          right: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Sell' ? const Color(0xffd23c3f) : Colors.grey,
                            width: 1
                          ),
                          bottom: BorderSide(
                            color: coinchartcontroller.tradeType.value == 'Sell' ? const Color(0xffd23c3f) : Colors.grey,
                            width: 1
                          ),
                        )
                      ),
                      child: Center(
                        child: Text(
                          'Sell',
                          style: TextStyle(
                            color: coinchartcontroller.tradeType.value == 'Sell' ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 10),
          
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: themeController.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1f2630),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [                  
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Value(${coinchartcontroller.faceValue.value})',
                          style: const TextStyle(
                            color: Colors.grey
                          ),
                        ),
                        Text(
                          formatter.format(double.parse(coinchartcontroller.trackballPrice.value)),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: themeController.theme.value == 'light' ? Colors.black : Colors.white
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 10),
          
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: themeController.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1f2630),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        coinchartcontroller.quantity.value -= 0.00001;
                        coinchartcontroller.quantityController.text = (coinchartcontroller.quantity.value).toStringAsFixed(5);
                      }, 
                      icon: const Icon(
                        FontAwesome.minus_solid,
                        size: 20,
                      )
                    ),
                    
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Quantity(${coinchartcontroller.shortName})',
                            style: const TextStyle(
                              color: Colors.grey
                            ),
                          ),
                          TextField(
                          
                            textAlign: TextAlign.center,
                            cursorColor: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                            controller: coinchartcontroller.quantityController,
                            style: TextStyle(
                              color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              border: InputBorder.none,
                              hintText: '0.00000',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          )
                          
                        ],
                      ),
                    ),
          
                    IconButton(
                      onPressed: () {
                        coinchartcontroller.quantity.value += 0.00001;
                        coinchartcontroller.quantityController.text = (coinchartcontroller.quantity.value).toStringAsFixed(5);
                      }, 
                      icon: const Icon(
                        FontAwesome.plus_solid,
                        size: 20,
                      )
                    )
                  ],
                ),
              ),
          
              const SizedBox(height: 10),
          
              Divider(
                color: themeController.theme.value == 'dark' ? Colors.grey : const Color(0xff1f2630),
                thickness: 0.5,
              ),
          
              const SizedBox(height: 10),
          
              CoinTotal(
                theme: themeController.theme.value, 
                faceValue: coinchartcontroller.faceValue.value,
              ),
          
              const SizedBox(height: 10),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${coinchartcontroller.tradeType.value} max',
                    style: TextStyle(
                      color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  Text(
                    '${(coinchartcontroller.appcontroller.userMoney.value / double.parse(coinchartcontroller.trackballPrice.value)).toStringAsFixed(5)} ${coinchartcontroller.shortName}',
                    style: TextStyle(
                      color: themeController.theme.value == 'light' ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
          
              const SizedBox(height: 10),
          
              GestureDetector(
                onTap: () {
                  if (coinchartcontroller.tradeType.value == 'Buy') {
                    coinchartcontroller.buyCoin();
                  }
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: coinchartcontroller.tradeType.value == 'Buy' ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(
                      coinchartcontroller.tradeType.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}