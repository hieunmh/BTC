import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/controllers/app/home_controller.dart';
import 'package:btc/pages/application/home/home_info.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        
              const SizedBox(height: 20),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your coin list',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    ),
                  )
                ],
              ),
        
              const SizedBox(height: 5),
        
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 10), 
                  itemCount: applicationcontroller.coinWatchList.length,
                  itemBuilder: (context, index) {
                    final item = applicationcontroller.coinWatchList[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 150,
                      decoration: BoxDecoration(
                        color: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['coin_name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            item['full_name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }
                ),
              ),
        
              const SizedBox(height: 20),
        
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Recommended for you',
                    style: TextStyle(
                      fontSize: 14
                    ),
                  )
                ],
              ),
        
              const SizedBox(height: 5),
        
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                          borderRadius: BorderRadius.circular(10)
                        ),
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