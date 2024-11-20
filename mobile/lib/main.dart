import 'package:btc/routes/pages.dart';
import 'package:btc/routes/routes.dart';
import 'package:btc/theme/app_theme.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Themecontroller themecontroller = Get.put(Themecontroller());

  @override
  Widget build(BuildContext context) {

    return Obx(() =>
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BTC',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themecontroller.theme.value == 'light' ? ThemeMode.light : ThemeMode.dark,
        getPages: AppPages.routes,
        initialRoute: AppRoutes.application
      ),
    );
  }
}

