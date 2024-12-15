import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CryptoController extends GetxController {

  final supabase = Supabase.instance.client;
  RxList<dynamic> coinList = <dynamic>[].obs;
  RxList<dynamic> coinTransHistory = <dynamic>[].obs;
  RxBool noCryptoData = true.obs;

  @override
  void onInit() {
    super.onInit();
    
    getCoinList();

    // supabase.from('CoinTransHistory').stream(primaryKey: ['id'])
    // .listen((event) {
    //   getCoinTransHistory();
    // });
  }

  void getCoinList() {
    supabase.from('Coins').stream(primaryKey: ['id'])
    .listen((event) {
      if (event.isEmpty) {
        noCryptoData.value = true;
      } else {
        coinList.value = event;
        noCryptoData.value = false;
      }
    });
  }

  Future<void> getCoinTransHistory() async {
    final res = await supabase.from('CoinTransHistory')
    .select('*, Coins(*)')
    .eq('user_id', supabase.auth.currentUser!.id);
    print(res);
  }
}