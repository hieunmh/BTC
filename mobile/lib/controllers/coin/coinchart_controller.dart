import 'dart:convert';

import 'package:btc/model/chart_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinchartController extends GetxController {
  
  late final String symbol;

  RxString timeFrame = '1m'.obs;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  List<String> timeFramesList = ['1m','3m', '5m', '15m', '30m', '1h', '2h', '4h', '6h', '8h', '12h', '1d', '3d', '1w'];
  RxString trackballPrice = '0.0'.obs;  
  RxString percentChange = '0.0'.obs;
  int limit = 100;
  RxString volume = ''.obs;
  RxString highPrice = '0.0'.obs;
  RxString lowPrice = '0.0'.obs;
  RxString avgPrice = '0.0'.obs;
  ScrollController scrollController = ScrollController();

  late final String name;
  late final String shortName;

  late final WebSocketChannel channel;


  @override
  void onInit() {
    final args = Get.arguments;
    symbol = args['symbol'];
    trackballPrice.value = args['price'];
    percentChange.value = args['percentChange'];
    name = args['name'];
    shortName = args['shortName'];
    getCoinPrices();
    connectWebSocket();
    super.onInit();
  }

  void setTrackballPrice(String price) {
    trackballPrice.value = price.toString();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@ticker'),
    );

    channel.stream.listen((event) {
      trackballPrice.value = json.decode(event)['c'];
      percentChange.value = json.decode(event)['P'];
      volume.value = json.decode(event)['v'];
      highPrice.value = json.decode(event)['h'];
      lowPrice.value = json.decode(event)['l'];
      avgPrice.value = json.decode(event)['w'];
    });
  }
  

  void getCoinPrices() async {
    chartData.clear();
    minPrice.value = 0.0;
    maxPrice.value = 0.0;

    final res = await http.get(
      Uri.parse('https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$timeFrame&limit=$limit')
    );

    json.decode(res.body).asMap().forEach((index, price) {
      chartData.add(ChartData(index + 1, double.parse(price[1]), price[0]));
    });



    minPrice.value = chartData.map((e) => e.price).reduce((a, b) => a < b ? a : b);
    maxPrice.value = chartData.map((e) => e.price).reduce((a, b) => a > b ? a : b);
  }
}