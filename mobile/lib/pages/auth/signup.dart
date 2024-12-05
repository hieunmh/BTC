import 'package:btc/controllers/auth/signup_controller.dart';
import 'package:btc/pages/auth/text_input.dart';
import 'package:btc/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {

    final SignupController signupcontroller = Get.find<SignupController>();

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f6f6),
        title: const Text(
          'Create account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Obx(() =>
              Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'We provide a full range of forex and crypto trading services for you.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  
                  const SizedBox(height: 20),
              
                  TextInput(
                    hintText: 'Email', 
                    placeholder: 'example@co.jp', 
                    obscureText: false, 
                    ctrler: signupcontroller.emailController, 
                    borderColor: Colors.transparent, 
                    errorMsg: signupcontroller.emailError.value
                  ),
              
                  const SizedBox(height: 10),
              
                  TextInput(
                    hintText: 'Password', 
                    placeholder: '••••••••', 
                    obscureText: true, 
                    ctrler: signupcontroller.passwordController, 
                    borderColor: Colors.transparent, 
                    errorMsg: signupcontroller.passwordError.value
                  ),
              
                  const SizedBox(height: 40),
              
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      signupcontroller.handleSignUp();
                    }, 
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xfffbc700),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: signupcontroller.isLoading.value ? const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ) : const Text(
                          'Create account',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                        ),
                      ),
                    )
                  ),
              
                  SizedBox(
                    height: 40,
                    child: Text(
                      signupcontroller.serverError.value,
                      style: const TextStyle(
                        color: Colors.red
                      ),
                    ),
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signin);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Color(0xfffbc700),
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      )
    );
  }
}