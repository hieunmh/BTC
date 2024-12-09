import 'package:btc/controllers/coin/coinchart_controller.dart';
import 'package:btc/pages/coin/chart_line.dart';
import 'package:btc/pages/coin/coin_statistics.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class CoinChartPage extends StatelessWidget {
  const CoinChartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final CoinchartController coinchartcontroller = Get.find<CoinchartController>();
    final ThemeController themecontroller = Get.find<ThemeController>();

    final formatter = NumberFormat("#,##0.000", "en_US");

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
          )
        ],
        body: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Obx(() =>
              Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '\$${formatter.format(double.parse(coinchartcontroller.trackballPrice.value))}',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: double.parse(coinchartcontroller.percentChange.value) > 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                          ),
                        ),
              
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              double.parse(coinchartcontroller.percentChange.value) >= 0 ? Iconsax.arrow_up_1_bold : Iconsax.arrow_down_bold,
                              color: double.parse(coinchartcontroller.percentChange.value) >= 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                              size: 20,
                            ),
              
                            Text(
                              '${formatter.format(double.parse(coinchartcontroller.percentChange.value).abs())}%',
                              style: TextStyle(
                                color: double.parse(coinchartcontroller.percentChange.value) > 0 ? const Color(0xff1bb455) : const Color(0xffd23c3f),
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                              ),
                            ),
                          ],
                        )
                      ],
                    )
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
              
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: 30,
                    child: ListView.separated(
                      itemCount: coinchartcontroller.timeFramesList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: 10), 
                      itemBuilder: (context, index) {
                        final item = coinchartcontroller.timeFramesList[index];
                        return GestureDetector(
                          onTap: () {
                            coinchartcontroller.timeFrame.value = item;
                            coinchartcontroller.getCoinPrices();
                          },
                          child: Container(
                            width: (Get.width) / 5,
                            decoration: BoxDecoration(
                              color: coinchartcontroller.timeFrame.value == item ? const Color(0xfffbc700) : Colors.transparent,
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
                                  color: coinchartcontroller.timeFrame.value == item ? Colors.white : const Color(0xfffbc700),
                                  fontWeight: coinchartcontroller.timeFrame.value == item ? FontWeight.bold : FontWeight.normal
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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