import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;

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

    } catch (e) {
      e.printError();
    }
  }
}