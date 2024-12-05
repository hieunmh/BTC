import 'package:btc/routes/pages.dart';
import 'package:btc/routes/routes.dart';
import 'package:btc/theme/app_theme.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  
  await Supabase.initialize(
    url: '${dotenv.env['SUPABASE_URL']}',
    anonKey: '${dotenv.env['SUPABASE_ANON_KEY']}',
  );
  final prefs = await SharedPreferences.getInstance();
  var initialRoute = prefs.getString('token') == null ? AppRoutes.splash : AppRoutes.application;

  runApp(MyApp(token: initialRoute));
}

class MyApp extends StatelessWidget {
  final String token;
  MyApp({super.key, required this.token});

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
        initialRoute: token
      ),
    );
  }
}

