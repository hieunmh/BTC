import 'dart:async';

import 'package:btc/model/coin_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarketController extends GetxController {
  final RxList<CoinModel>  coinList = <CoinModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() { 
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
       getCoinMarket();
    });
  }

  @override
  void dispose() {  

    super.dispose();
  }

  Future getCoinMarket() async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true');
    final response = await http.get(url);
    isLoading.value = false;

    if (response.statusCode == 200) {
      coinList.value = coinModelFromJson(response.body);
    } 
    print('123');
  }
}