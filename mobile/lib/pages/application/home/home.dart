import 'package:btc/controllers/app/home_controller.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final ThemeController themecontroller = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
      appBar: AppBar(
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        toolbarHeight: 0,
        scrolledUnderElevation: 0.0,
      ),
      body: Padding(
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
                          homeController.supabase.auth.currentUser!.email!,
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
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xfffbc700),
                borderRadius: BorderRadius.circular(10)
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
      )
    );
  }
}