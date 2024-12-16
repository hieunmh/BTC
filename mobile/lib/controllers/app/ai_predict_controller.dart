import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AiPredictController extends GetxController {
  final openPriceController = TextEditingController();
  final highPriceController = TextEditingController();
  final lowPriceController = TextEditingController();
  final closePriceController = TextEditingController();
  RxString errorMsg = ''.obs;
  RxString prediction = ''.obs;
  
  RxBool isLoading = false.obs;
  List<String> algoList = ['bayes', 'knn', 'decision_tree'];
  RxString selectedAlgo = 'bayes'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    openPriceController.dispose();
    highPriceController.dispose();
    lowPriceController.dispose();
    closePriceController.dispose();
    super.onClose();
  }

  void reset() {
    openPriceController.clear();
    highPriceController.clear();
    lowPriceController.clear();
    closePriceController.clear();
    errorMsg.value = '';
    prediction.value = '';
  }

  Future<void> predict() async {

    if (openPriceController.text.isEmpty || highPriceController.text.isEmpty || lowPriceController.text.isEmpty || closePriceController.text.isEmpty) {
      errorMsg.value = 'Please fill all fields';
      return;
    }

    errorMsg.value = '';

    try {
      isLoading.value = true;

      final queryParams = {
        'open': openPriceController.text.replaceAll(RegExp(r'[^\d]'), ''),
        'high': highPriceController.text.replaceAll(RegExp(r'[^\d]'), ''),
        'low': lowPriceController.text.replaceAll(RegExp(r'[^\d]'), ''),
        'close': closePriceController.text.replaceAll(RegExp(r'[^\d]'), ''),
        'model': selectedAlgo.value,
      };

      final uri = Uri.parse('http://127.0.0.1:8000/predict');

      final res = await http.get(
        uri.replace(queryParameters: queryParams),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      prediction.value = json.decode(res.body)['prediction'];

      Get.snackbar(
        'Prediction',
        '$prediction',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xff1f2630),
        colorText: Colors.white,
      );

    } catch (e) {
      e.printError();
      
    } finally {
      isLoading.value = false;
    }
  }
}