import 'package:btc/controllers/app/profile_controller.dart';
import 'package:btc/pages/application/profile/theme_button.dart';
import 'package:btc/routes/routes.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileController profilecontroller = Get.find<ProfileController>();
    final ThemeController themecontroller = Get.find<ThemeController>();
    
    return Obx(() =>
      Scaffold(
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ThemeButton(
                      toggleTheme: themecontroller.toggleTheme,
                      theme: themecontroller.theme.value
                    ),
                
                    const SizedBox(height: 15),
                
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.chat);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: themecontroller.theme.value == 'light' ? Colors.white : const Color(0xff1f2630),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              color: themecontroller.theme.value == 'light' ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    
                const SizedBox(height: 20),
            
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                  ),
                  onPressed: () {
                    profilecontroller.handleSignOut();
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xfffbc700),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}