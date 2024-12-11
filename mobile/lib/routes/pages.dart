import 'package:btc/bindings/app/application_binding.dart';
import 'package:btc/bindings/auth/signin_binding.dart';
import 'package:btc/bindings/auth/signup_binding.dart';
import 'package:btc/bindings/chat/chat_binding.dart';
import 'package:btc/bindings/coin/coinchart_binding.dart';
import 'package:btc/pages/application/application.dart';
import 'package:btc/pages/auth/signin.dart';
import 'package:btc/pages/auth/signup.dart';
import 'package:btc/pages/auth/spash.dart';
import 'package:btc/pages/chat/chat.dart';
import 'package:btc/pages/coin/coin.dart';
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
    ),
    GetPage(
      name: AppRoutes.coinchart, 
      page: () => const CoinPage(),
      binding: CoinChartBinding()
    ),
    GetPage(
      name: AppRoutes.chat, 
      page: () => const ChatPage(),
      binding: ChatBinding()
    )
  ];
}