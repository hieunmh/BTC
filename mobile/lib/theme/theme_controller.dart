import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themecontroller extends GetxController {
  var themeStatus = 'theme_status';
  var theme = 'light'.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   theme.value = 'light';
  // }

  void toggleTheme() async {
    theme.value = theme.value == 'light' ? 'dark' : 'light';
    Get.changeThemeMode(theme.value == 'light' ? ThemeMode.light : ThemeMode.dark);
    setThemePreferences(theme.value);
  }

  Future<void> setThemePreferences(String theme) async  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeStatus, theme);
  }

  Future<void> getThemePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme.value = prefs.getString(themeStatus) ?? 'light';
    Get.changeThemeMode(theme.value == 'light' ? ThemeMode.light : ThemeMode.dark);
  }
}