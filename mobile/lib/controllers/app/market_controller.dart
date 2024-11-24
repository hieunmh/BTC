import 'dart:async';

import 'package:btc/model/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarketController extends GetxController {
  final RxList<CoinModel>  coinList = <CoinModel>[].obs;
  final RxList<CoinModel>  filterList = <CoinModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool noData = false.obs;
  late final Timer? timer;
  final filterSearch = TextEditingController();

  @override
  void onInit() { 
    super.onInit();
    getCoinMarket();
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      getCoinMarket();
    });
  }

  @override
  void onClose() {  
    timer?.cancel();
    super.onClose();
  }

  void filterCoins(String query) {
    if (query.isEmpty) {
      filterList.value = coinList;
    } else {
      filterList.value = coinList.where((coin) {
        return coin.name.toLowerCase().contains(query.toLowerCase())
        || coin.symbol.toLowerCase().contains(query.toLowerCase());
      }).toList();
      if (filterList.isEmpty) {
        noData.value = true;
      } else {
        noData.value = false;
      }
    }
  }


  Future getCoinMarket() async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true');
    final response = await http.get(url);
    isLoading.value = false;

    if (response.statusCode == 200) {
      coinList.value = coinModelFromJson(response.body);
      filterList.value = coinModelFromJson(response.body).where((coin) {
        return coin.name.toLowerCase().contains(filterSearch.text.toLowerCase())
        || coin.symbol.toLowerCase().contains(filterSearch.text.toLowerCase());
      }).toList();
    } 
  }
}