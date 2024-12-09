import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;

  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
  }
}