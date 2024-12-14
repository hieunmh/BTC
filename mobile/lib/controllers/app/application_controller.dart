import 'dart:convert';

import 'package:btc/model/coin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApplicationController extends GetxController {
    
  final RxString theme = 'dark'.obs;
  late final PageController pageController;
  final RxInt currentPage = 0.obs;
  final RxBool isAnimate = false.obs;
  final RxString userId = ''.obs;
  final RxString userEmail = ''.obs;
  final RxDouble userMoney = 0.0.obs;

  final RxList<Coin>  coinList = <Coin>[].obs;
  final RxList<Coin>  filterCoinList = <Coin>[].obs;
  final RxBool isLoading = true.obs;
  final List<String> faceValueList = ['USDT', 'FDUSD', 'USDC', 'TUSD', 'BNB', 'BTC', 'ALTS', 'FIAT'];
  final RxString defaultFaceValue = 'USDT'.obs;
  late final WebSocketChannel channel;
  final RxBool noData = false.obs;
  final filterSearch = TextEditingController();
  final RxList<dynamic> coinWatchList = <dynamic>[].obs;


  final supabase = Supabase.instance.client;

  final bottomNavBar = const [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Iconsax.home_2_outline),
      activeIcon: Icon(Iconsax.home_2_bold),
    ),
    BottomNavigationBarItem(
      label: 'Market',
      icon: Icon(Iconsax.bag_2_outline),
      activeIcon: Icon(Iconsax.bag_2_bold),
    ),
    BottomNavigationBarItem(
      label: 'Crypto',
      icon: Icon(Iconsax.coin_outline),
      activeIcon: Icon(Iconsax.coin_1_bold),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(Iconsax.user_octagon_outline),
      activeIcon: Icon(Iconsax.user_octagon_bold)
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    getCoinMarket();
    websocketConnect();
    pageController = PageController(initialPage: currentPage.value);
    if (userId.value.isEmpty) {
      getUserInfo();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void websocketConnect() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr'),
    );

    channel.stream.listen((event) {
      final coinData = json.decode(event);
      for (var coin in coinData) {
        final String symbol = coin['s']; 
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

    isLoading.value = false;
    filterCoinList.value = coinList.where((coin) => coin.faceValue == defaultFaceValue.value).toList();

    getWatchList();
  }

  Future<void> getWatchList() async {
    final watchList = await supabase.from('CoinWatchList').select().eq('user_id', supabase.auth.currentUser!.id);
    if (watchList.isEmpty) {
      return;
    } else {
      coinWatchList.assignAll(watchList);
    }
  }

  Future<void> getUserInfo() async {
    final res = await supabase.from('Users').select().eq('id', supabase.auth.currentUser!.id).single();
    userId.value = res['id'].toString();
    userEmail.value = res['email'].toString();
    userMoney.value = res['money'].toDouble();
  }

  void handlePageChange(int index) {
    if (!isAnimate.value) {
      currentPage.value = index;
    }
  }

  void handleNavbarChange(int index) {
    isAnimate.value = true;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ).then((_) {
      isAnimate.value = false;
    });
    currentPage.value = index;
  }
}