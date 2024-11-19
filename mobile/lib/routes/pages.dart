import 'package:btc/bindings/app/application_binding.dart';
import 'package:btc/bindings/auth/auth_binding.dart';
import 'package:btc/pages/application/application.dart';
import 'package:btc/pages/auth/auth.dart';
import 'package:btc/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.application, 
      page:() => const ApplicationPage(),
      binding: ApplicationBinding()
    ),
    GetPage(
      name: AppRoutes.auth, 
      page: () => const AuthPage(),
      binding: AuthBinding()
    )
  ];
}