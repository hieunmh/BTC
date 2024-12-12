import 'dart:convert';

import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/model/chart_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class CoinchartController extends GetxController {
  
  late final String symbol;
  final quantityController = TextEditingController(text: '0.0000');
  final ApplicationController appcontroller = Get.find<ApplicationController>();
  final supabase = Supabase.instance.client;

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
  RxString tradeType = 'Buy'.obs;
  String faceValue = '';
  RxDouble quantity = 0.0000.obs;
  
  RxString action = ''.obs;

  final ApplicationController applicationcontroller = Get.find<ApplicationController>();
  

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
    faceValue = args['faceValue'];
    getCoinPrices();
    connectWebSocket();
    checkAction();
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

  Future<void> buyCoin() async {
    try {
      await supabase.from('Coins').insert({
        'id': const Uuid().v4(),
        'coin_name': '$shortName/$faceValue',
        'user_id': appcontroller.userId.value,
        'amount': double.parse(quantityController.text),
        'average_price': double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)),
        'first_time_buy': DateTime.now().toString(),
      });

      appcontroller.userMoney.value -= double.parse(quantityController.text) * double.parse(trackballPrice.value);

      await supabase.from('Users').update({
        'money': appcontroller.userMoney.value - (double.parse(quantityController.text) * double.parse(trackballPrice.value))
      }).eq('id', appcontroller.userId.value);

    } catch (e) {
      e.printError();
    }
  }

  Future<void> sellCoin() async {

  }

  void resetTracsaction() {

  }

  Future<void> addToWatchList() async {
    try {
      await supabase.from('CoinWatchList').insert({
        'id': const Uuid().v4(),
        'coin_name': '$shortName/$faceValue',
        'user_id': appcontroller.userId.value,
        'full_name': name,
        'createdAt': DateTime.now().toString(),
      });

      appcontroller.getWatchList();
    } catch (e) {
      e.printError();
    } finally {
      action.value = 'remove';
    }
  }

  Future<void> removeFromWatchList() async {
    try {
      await supabase.from('CoinWatchList').delete().eq('coin_name', '$shortName/$faceValue').eq('user_id', appcontroller.userId.value);
      appcontroller.getWatchList();
    } catch (e) {
      e.printError();
    } finally {
      action.value = 'add';
    } 

  }

  void checkAction() {
    for (var coin in applicationcontroller.coinWatchList) {
      if (coin['coin_name'] == '$shortName/$faceValue') {
        action.value = 'remove';
        return;
      } else {
        action.value = 'add';
      }
    }
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

  void setTimeFrame(String timeFrame) {
    this.timeFrame.value = timeFrame;
  }
}