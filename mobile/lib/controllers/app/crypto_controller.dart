import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CryptoController extends GetxController {

  final supabase = Supabase.instance.client;
  RxList<dynamic> coinList = <dynamic>[].obs;
  RxList<dynamic> coinTransHistory = <dynamic>[].obs;
  RxBool noCryptoData = true.obs;
  RxBool noHistoryData = true.obs;

  @override
  void onInit() {
    super.onInit();
    
    getCoinList();
    getCoinTransHistory();
  }

  void getCoinList() {
    supabase.from('Coins').stream(primaryKey: ['id'])
    .listen((event) async {
      final res = await supabase.from('Coins')
      .select()
      .eq('user_id', supabase.auth.currentUser!.id)
      .order('first_time_buy', ascending: false);

      if (res.isEmpty) {
        noCryptoData.value = true;
      } else {
        coinList.assignAll(res);
        noCryptoData.value = false;
      }
    });
  }

  void getCoinTransHistory() {
    supabase.from('CoinTransHistory').stream(primaryKey: ['id'])
    .listen((event) async {
      final res = await supabase.from('CoinTransHistory')
      .select('*')
      .eq('user_id', supabase.auth.currentUser!.id)
      .order('created_at', ascending: false);

      if (res.isEmpty) {
        noHistoryData.value = true;
      } else {
        coinTransHistory.assignAll(res);
        noHistoryData.value = false;
      }
    });
  }
}