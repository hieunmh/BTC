import 'package:btc/controllers/coin/coinchart_controller.dart';
import 'package:get/get.dart';

class CoinChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinchartController>(() => CoinchartController());
  }
}