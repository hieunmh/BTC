// ignore_for_file: invalid_use_of_protected_member

import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/controllers/app/home_controller.dart';
import 'package:btc/pages/application/home/home_coinlwatchlist.dart';
import 'package:btc/pages/application/home/home_info.dart';
import 'package:btc/pages/application/home/home_new_card.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themecontroller = Get.find<ThemeController>();
    final ApplicationController applicationcontroller = Get.find<ApplicationController>();
    final HomeController homecontroller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
      appBar: AppBar(
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: Obx(() =>
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              HomeInfo(
                userEmail: homecontroller.supabase.auth.currentUser!.email ?? '',
                userMoney: applicationcontroller.userMoney.value,
              ),
        
              const SizedBox(height: 15),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your coin watch list',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 5),
        
              homecontroller.isLoadingCoinList.value ? SizedBox(
                height: 80,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
                    size: 24
                  ),
                )
              ) : HomeCoinWatchlist(
                theme: themecontroller.theme.value,
                coinWatchList: applicationcontroller.coinWatchList.value
              ),
        
              const SizedBox(height: 15),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'News',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  )
                ],
              ),
        
              const SizedBox(height: 5),
        
              homecontroller.isLoadingNews.value ? Expanded(
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white, 
                    size: 24
                  ),
                )
              ) : Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.separated(
                    itemCount: homecontroller.newsList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final news = homecontroller.newsList[index];
                      return HomeNewCard(
                        title: news['title'],
                        url: news['url'],
                        urlToImage: news['urlToImage'],
                        launchBrowser: homecontroller.lauchBrowser
                      );
                    }
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}