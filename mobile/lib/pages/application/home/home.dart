import 'package:btc/controllers/app/application_controller.dart';
import 'package:btc/controllers/app/home_controller.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themecontroller = Get.find<ThemeController>();
    final ApplicationController applicationcontroller = Get.find<ApplicationController>();
    final HomeController homecontroller = Get.find<HomeController>();

    final formatter = NumberFormat("#,##0.00", "en_US");


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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/user-placeholder.png', 
                          width: 50, 
                          height: 50, 
                          fit: BoxFit.cover
                        ),
                      ),
        
                      const SizedBox(width: 10),
        
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                            ),
                          ),
                          Text(
                            homecontroller.supabase.auth.currentUser!.email ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          )
                        ],
                      )
                    ],
                  ),
        
                  const Icon(
                    Iconsax.notification_outline,
                    size: 24,
                  )
                ],
              ),
        
              const SizedBox(height: 20),
        
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                decoration: BoxDecoration(
                  color: const Color(0xfffbc700),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Total balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        Text(
                          '\$${formatter.format(double.parse(applicationcontroller.userMoney.value.toString()))}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),

                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesome.arrow_trend_up_solid,
                              color: Color(0xfffbc700),
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '0.5%',
                              style: TextStyle(
                                color: Color(0xfffbc700),
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                        borderRadius: BorderRadius.circular(10)
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
                ))
            ],
          ),
        ),
      )
    );
  }
}