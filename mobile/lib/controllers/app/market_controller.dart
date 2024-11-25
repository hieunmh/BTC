import 'dart:async';
import 'dart:convert';

import 'package:btc/model/coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketController extends GetxController {
  final RxList<Coin>  coinList = <Coin>[].obs;
  final RxList<Coin>  filterCoinList = <Coin>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool noData = false.obs;
  late final Timer? timer;
  late final WebSocketChannel channel;
  final filterSearch = TextEditingController();
  final List<String> faceValueList = ['USDT', 'FDUSD', 'USDC', 'TUSD', 'BNB', 'BTC', 'ALTS', 'FIAT'];
  final RxString defaultFaceValue = 'USDT'.obs;
  final faceValueScrollController = ScrollController();

  @override
  void onInit() { 
    super.onInit();
    getCoinMarket();
    websocketConnect();
  }

  @override
  void onClose() {  
    channel.sink.close();
    super.onClose();
  }

  void scrollToCurrentFaceValue() {
    final selectedFaceValue  = faceValueList.indexOf(defaultFaceValue.value);
    final maxItemPerScreen = (Get.width / 100.0).round();

    if (selectedFaceValue >= (maxItemPerScreen / 2).round() && 
      selectedFaceValue < faceValueList.length - (maxItemPerScreen / 2).round()
    ) {
      final scrollOffset = (selectedFaceValue * 110.0) - Get.width / 2 + 60;
      faceValueScrollController.animateTo(
        scrollOffset, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }

    if (selectedFaceValue < (maxItemPerScreen / 2).round()) {
      faceValueScrollController.animateTo(
        0, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }

    if (selectedFaceValue >= faceValueList.length - (maxItemPerScreen / 2).round()) {
      faceValueScrollController.animateTo(
        faceValueScrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }
  }

  void websocketConnect() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr'),
    );

    channel.stream.listen((event) {
      final coinData = json.decode(event);
      for (var coin in coinData) {
        final String symbol = coin['s']; // Lấy tên cặp coin, ví dụ: BTCUSDT
        final String newPrice = coin['c'];
        final String newPercentChange = coin['P']; 
        
        final index = filterCoinList.indexWhere((element) => element.symbol == symbol);

        if (index != -1) {
          filterCoinList[index].price = newPrice;
          filterCoinList[index].percentChange = newPercentChange;
          filterCoinList.refresh();
        }

      }
    });
  }

  filterCoinsFaceValue() {
    filterCoinList.value = coinList.where((coin) {
      if (filterSearch.text.isEmpty) {
        return coin.faceValue == defaultFaceValue.value;
      }

      return coin.faceValue == defaultFaceValue.value && 
      (coin.name.toLowerCase().contains(filterSearch.text.toLowerCase())
      || coin.shortName.toLowerCase().contains(filterSearch.text.toLowerCase()));
    }).toList();

    if (filterCoinList.isEmpty) {
      noData.value = true;
    } else {
      noData.value = false;
    }
  }


  Future getCoinMarket() async {
    final res = await http.get(
      Uri.parse('https://www.binance.com/bapi/asset/v2/public/asset-service/product/get-products'),
    );
    isLoading.value = false;

    for (var coin in json.decode(res.body)['data']) {
      coinList.add(Coin(
        symbol: coin['s'],
        shortName: coin['b'],
        name: coin['an'],
        price: coin['c'],
        faceValue: coin['pm'],
      ));
    }

    final res2 = await http.get(
      Uri.parse('https://api.binance.com/api/v3/ticker/24hr'),
    );

    for (var percentCoin in json.decode(res2.body)) {
      for (var coin in coinList) {
        if (coin.symbol == percentCoin['symbol']) {
          coin.percentChange = percentCoin['priceChangePercent'];
        }
      }
    }

    filterCoinList.value = coinList.where((coin) => coin.faceValue == defaultFaceValue.value).toList();
  }
}