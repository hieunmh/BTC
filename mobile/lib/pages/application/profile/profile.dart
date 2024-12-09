import 'package:btc/controllers/app/profile_controller.dart';
import 'package:btc/pages/application/profile/theme_button.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileController profilecontroller = Get.find<ProfileController>();
    final ThemeController themecontroller = Get.find<ThemeController>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Obx(() =>
          Column(
            children: [
              ThemeButton(
                toggleTheme: themecontroller.toggleTheme,
                theme: themecontroller.theme.value
              ),
          
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
                ),
                onPressed: () {
                  profilecontroller.handleSignOut();
                }, 
                child: Container(
                    padding: const EdgeInsets.all(10),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}