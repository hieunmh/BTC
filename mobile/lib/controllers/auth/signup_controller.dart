import 'package:btc/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString serverError = ''.obs;  
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailError.close();
    passwordError.close();
    super.onClose();
  }

  Future<void> handleSignUp() async {
    if (emailController.text.isEmpty) {
      emailError.value = 'Please enter your email';
    }
    else if (!emailController.text.isEmail) {
      emailError.value = 'Please enter a valid email';
    } else {
      emailError.value = '';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Please enter your password';
    } else {
      passwordError.value = '';
    }

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await supabase.auth.signUp(
          email: emailController.text,
          password: passwordController.text
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();

        final token = supabase.auth.currentSession?.accessToken;
        await prefs.setString('token', token!);
        Get.offAllNamed(AppRoutes.application);

      } catch (e) {
        serverError.value = 'This email has been registered';
      } finally {
        isLoading.value = false;
      }
    }

  }
}