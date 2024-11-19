import 'package:btc/bindings/app/application_binding.dart';
import 'package:btc/bindings/auth/signin_binding.dart';
import 'package:btc/bindings/auth/signup_binding.dart';
import 'package:btc/pages/application/application.dart';
import 'package:btc/pages/auth/signin.dart';
import 'package:btc/pages/auth/signup.dart';
import 'package:btc/pages/auth/spash.dart';
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
      name: AppRoutes.signin, 
      page: () => const SigninPage(),
      binding: SigninBinding()
    ),
    GetPage(
      name: AppRoutes.signup, 
      page: () => const SignupPage(),
      binding: SignupBinding(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 1000)
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    )
  ];
}