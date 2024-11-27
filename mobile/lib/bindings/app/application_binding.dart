import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/controllers/app/home_controller.dart';
import 'package:btc/controllers/app/market_controller.dart';
import 'package:get/get.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}