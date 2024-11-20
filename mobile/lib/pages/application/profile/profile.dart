import 'package:btc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(50)),
                ),
                onPressed: () {
                  Get.offAllNamed(AppRoutes.signup);
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