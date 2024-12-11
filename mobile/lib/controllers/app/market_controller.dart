import 'dart:async';

import 'package:btc/controllers/app/application_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MarketController extends GetxController {
  late final Timer? timer;
  late final WebSocketChannel channel;
  final faceValueScrollController = ScrollController();
  final applicationCOntroller = Get.find<ApplicationController>();

  @override
  void onInit() { 
    super.onInit();
  }

  @override
  void onClose() {  
    channel.sink.close();
    super.onClose();
  }

  void scrollToCurrentFaceValue(String faceValue, List<String> faceValueList, String defaultFaceValue) {
    final selectedFaceValue  = faceValueList.indexOf(defaultFaceValue);
    final maxItemPerScreen = (Get.width / 100.0).round();

    if (selectedFaceValue >= (maxItemPerScreen / 2).round() && 
      selectedFaceValue < faceValueList.length - (maxItemPerScreen / 2).round()
    ) {
      final scrollOffset = (selectedFaceValue * 110.0) - Get.width / 2 + 60;
      faceValueScrollController.animateTo(
        scrollOffset, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }

    if (selectedFaceValue < (maxItemPerScreen / 2).round()) {
      faceValueScrollController.animateTo(
        0, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }

    if (selectedFaceValue >= faceValueList.length - (maxItemPerScreen / 2).round()) {
      faceValueScrollController.animateTo(
        faceValueScrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.ease
      );
    }
  }
}