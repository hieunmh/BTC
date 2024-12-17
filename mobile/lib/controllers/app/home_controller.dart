import 'dart:convert';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;

  final supabase = Supabase.instance.client;

  RxList<dynamic> coinList = <dynamic>[].obs;
  RxList<dynamic> newsList = <dynamic>[].obs;
  RxBool isLoadingNews = false.obs;
  RxBool isLoadingCoinList = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCoinWatchList();
    getNews();
  }

  Future<void> getCoinWatchList() async {
    try {
      isLoadingCoinList.value = true;
      final res = await supabase.from('Coins').select('*').eq('user_id', supabase.auth.currentUser!.id);
      coinList.assignAll(res);

    } catch (e) {
      e.printError();
    }
    isLoadingCoinList.value = false;
  }

  Future<void> getNews() async {
    try {
      isLoadingNews.value = true;
      final res = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=crypto&sortBy=publishedAt&apiKey=44fff84f274244c9854593b49df128a3'));
      newsList.assignAll(json.decode(res.body)['articles']);
    } catch (e) {
      e.printError();
    }
    isLoadingNews.value = false;
  }

  Future<void> lauchBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }
}