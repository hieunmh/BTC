// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/model/chart_data.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class CoinchartController extends GetxController {
  
  late final String symbol;
  final quantityController = TextEditingController(text: '0.00001');
  final ApplicationController appcontroller = Get.find<ApplicationController>();
  final ThemeController themecontroller = Get.find<ThemeController>();
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
  RxString action = ''.obs;
  RxBool isLoading = false.obs;
  RxDouble sellMax = 0.00000.obs;
  RxDouble buyMax = 0.00000.obs;

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
    getCoinAmount();
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

      buyMax.value = double.parse((appcontroller.userMoney.value / double.parse(json.decode(event)['c'])).toStringAsFixed(5));
    });

  }

  Future<void> getCoinAmount() async {
    try {
      final coin = await supabase.from('Coins').select()
      .eq('user_id', appcontroller.userId.value)
      .eq('coin_name', '$shortName/$faceValue/$name').single();  

      if (coin.isNotEmpty) {
        sellMax.value = coin['amount'];
      }
    } catch (e) {
      e.printError();
    }
  }

  Future<void> buyCoin() async {
    if (double.parse(quantityController.text) >= buyMax.value) {
      quantityController.text = buyMax.value.toStringAsFixed(5);
    }

    try {
      isLoading.value = true;
      final coin = await supabase.from('Coins')
      .select()
      .eq('coin_name', '$shortName/$faceValue/$name')
      .eq('user_id', appcontroller.userId.value);

      if (coin.isEmpty) {
        final coin_id = const Uuid().v4();
        await supabase.from('Coins').insert({
          'id': coin_id,
          'coin_name': '$shortName/$faceValue/$name',
          'user_id': appcontroller.userId.value,
          'amount': double.parse(quantityController.text),
          'average_price': double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)),
          'first_time_buy': DateTime.now().toString(),
        });

        await supabase.from('CoinTransHistory').insert({
          'user_id': appcontroller.userId.value,
          'coin_name': '$shortName/$faceValue/$name',
          'type_order': 'Buy',
          'amount': double.parse(quantityController.text),
          'price': double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)),
          'created_at': DateTime.now().toString(),
        });

      } else {
        await supabase.from('Coins').update({
          'amount': coin[0]['amount'] + double.parse(quantityController.text),
          'average_price': (coin[0]['average_price'] * coin[0]['amount'] + double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)) * double.parse(quantityController.text)) / (coin[0]['amount'] + double.parse(quantityController.text)),
        })
        .eq('coin_name', '$shortName/$faceValue/$name')
        .eq('user_id', appcontroller.userId.value);

        await supabase.from('CoinTransHistory').insert({
          'user_id': appcontroller.userId.value,
          'coin_name': '$shortName/$faceValue/$name',
          'type_order': 'Buy',
          'amount': double.parse(quantityController.text),
          'price': double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)),
          'created_at': DateTime.now().toString(),
        });
      }
    
      appcontroller.userMoney.value -= double.parse(quantityController.text) * double.parse(trackballPrice.value);

      await supabase.from('Users').update({
        'money': appcontroller.userMoney.value - (double.parse(quantityController.text) * double.parse(trackballPrice.value))
      }).eq('id', appcontroller.userId.value);
      appcontroller.userMoney.value -= double.parse(quantityController.text) * double.parse(trackballPrice.value);
      sellMax.value += double.parse(double.parse(quantityController.text).toStringAsFixed(5));
      resetTracsaction();
      Get.back();

    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sellCoin() async {
    if (double.parse(quantityController.text) >= sellMax.value) {
      quantityController.text = sellMax.value.toStringAsFixed(5);
    }

    if (sellMax.value == 0.00000) {
      Get.snackbar(
        'Error',
        'You do not have any $name to sell',
        overlayBlur: 0,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
        titleText: Text(
          'Error', 
          style: TextStyle(
            color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 16
          )
        ),
        messageText: Text(
          'You do not have any $name to sell',
          style: TextStyle(
            color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
            fontSize: 14,
            fontWeight: FontWeight.w500
          )
        ),
      );
      return;
    }

    try {
      isLoading.value = true;
      final coin = await supabase.from('Coins').select()
      .eq('coin_name', '$shortName/$faceValue/$name')
      .eq('user_id', appcontroller.userId.value).single();

      if (coin['amount'] == double.parse(quantityController.text)) {
        await supabase.from('Coins').delete().eq('coin_name', '$shortName/$faceValue/$name').eq('user_id', appcontroller.userId.value);
      } else {
        await supabase.from('Coins').update({
          'amount': coin['amount'] - double.parse(quantityController.text),
        }).eq('coin_name', '$shortName/$faceValue/$name').eq('user_id', appcontroller.userId.value);
      }

      await supabase.from('CoinTransHistory').insert({
        'user_id': appcontroller.userId.value,
        'coin_name': '$shortName/$faceValue/$name',
        'type_order': 'Sell',
        'amount': double.parse(quantityController.text),
        'price': double.parse(double.parse(trackballPrice.value).toStringAsFixed(2)),
        'created_at': DateTime.now().toString(),
      });

      await supabase.from('Users').update({
        'money': appcontroller.userMoney.value + (double.parse(quantityController.text) * double.parse(trackballPrice.value))
      }).eq('id', appcontroller.userId.value);


      appcontroller.userMoney.value += double.parse(quantityController.text) * double.parse(trackballPrice.value);
      sellMax.value -= double.parse(double.parse(quantityController.text).toStringAsFixed(5));
      resetTracsaction();
      Get.back();
    } catch (e) {
      e.printError();
    } finally {
      isLoading.value = false;
    }


  }

  void resetTracsaction() {
    quantityController.text = '0.00001';
    tradeType.value = 'Buy';
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