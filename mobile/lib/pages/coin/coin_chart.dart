import 'package:btc/controllers/coin/coinchart_controller.dart';
import 'package:btc/pages/coin/chart_line.dart';
import 'package:btc/pages/coin/coin_facevalue.dart';
import 'package:btc/pages/coin/coin_price.dart';
import 'package:btc/pages/coin/coin_statistics.dart';
import 'package:btc/pages/coin/coin_trade.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class CoinChartPage extends StatelessWidget {
  const CoinChartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final CoinchartController coinchartcontroller = Get.find<CoinchartController>();
    final ThemeController themecontroller = Get.find<ThemeController>();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            pinned: true,
            backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
            scrolledUnderElevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    coinchartcontroller.name,
                    style:  TextStyle(
                      color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    coinchartcontroller.shortName,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),  
                        title: Center(
                          child: Text(
                            '${coinchartcontroller.shortName}/${coinchartcontroller.faceValue.value}',
                            style: TextStyle(
                              color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        
                        titlePadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1b2129),
                        insetPadding: EdgeInsets.zero,
                        content: const CoinTrade()
                        
                      );
                    }
                  );
                },
                icon: Icon(
                  FontAwesome.plus_solid,
                  size: 20,
                  color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
                ),
              )
            ],
          )
        ],
        body: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Obx(() =>
              Column(
                children: [
                  CoinPrice(
                    trackballPrice: coinchartcontroller.trackballPrice.value, 
                    percentChange: coinchartcontroller.percentChange.value
                  ),
              
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: ChartLine(
                      limit: coinchartcontroller.limit,
                      percentChange: double.parse(coinchartcontroller.percentChange.value),
                      minPrice: coinchartcontroller.minPrice.value,
                      maxPrice: coinchartcontroller.maxPrice.value,
                      chartData: coinchartcontroller.chartData,
                      setTrackballPrice: coinchartcontroller.setTrackballPrice,
                    )
                  ),
              
                  const SizedBox(height: 15),
              
                  CoinFacevalue(
                    timeFramesList: coinchartcontroller.timeFramesList, 
                    timeFrame: coinchartcontroller.timeFrame.value, 
                    getCoinPrices: coinchartcontroller.getCoinPrices, 
                    setTimeFrame: coinchartcontroller.setTimeFrame
                  ),
              
                  const SizedBox(height: 15),
              
                  CoinStatistics(
                    theme: themecontroller.theme.value,
                    lowPrice: coinchartcontroller.lowPrice.value, 
                    highPrice: coinchartcontroller.highPrice.value, 
                    avgPrice: coinchartcontroller.avgPrice.value
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}