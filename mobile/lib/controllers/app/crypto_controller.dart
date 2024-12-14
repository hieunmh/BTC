import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CryptoController extends GetxController {

  final supabase = Supabase.instance.client;
  RxList<dynamic> coinList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCoinList();
  }

  Future<void> getCoinList() async {
    try {
      final res = await supabase.from('Coins').select('*').eq('user_id', supabase.auth.currentUser!.id);
      coinList.assignAll(res);

    } catch (e) {
      e.printError();
    }
  }

}