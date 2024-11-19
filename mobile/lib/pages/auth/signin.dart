import 'package:btc/controllers/auth/signin_controller.dart';
import 'package:btc/pages/auth/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {

    final SigninController signincontroller = Get.find<SigninController>();

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f6f6),
        title: const Text(
          'Sign in',
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
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome back! Please sign in to your account.',
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
                  ctrler: signincontroller.emailController, 
                  borderColor: Colors.transparent, 
                  errorMsg: signincontroller.emailError.value
                ),

                const SizedBox(height: 10),

                TextInput(
                  hintText: 'Password', 
                  placeholder: '••••••••', 
                  obscureText: true, 
                  ctrler: signincontroller.passwordController, 
                  borderColor: Colors.transparent, 
                  errorMsg: signincontroller.passwordError.value
                ),

                const SizedBox(height: 40),

                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                  ),
                  onPressed: () {
                    signincontroller.handleSignIn();
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xfffbc700),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  )
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xfffbc700),
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ),
        ),
      )
    );
  }
}