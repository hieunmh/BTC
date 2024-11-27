import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;

  @override
  void onInit() {
    connectWebSocket();
    super.onInit();
  }

  void connectWebSocket() async {
  }
}