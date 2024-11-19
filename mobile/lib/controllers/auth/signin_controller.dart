import 'package:btc/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  Future<void> handleSignIn() async {
    Get.offAllNamed(AppRoutes.application);
  }
}