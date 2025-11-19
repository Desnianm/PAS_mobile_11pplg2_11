import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/custom_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    final username = TextEditingController();
    final fullName = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffF5F2FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ICON
              const Icon(
                Icons.person_add_alt_1_rounded,
                size: 75,
                color: Color(0xff6F69AC),
              ),

              const SizedBox(height: 12),

              // Title
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3D3A50),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Register to get started",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Card wrapper
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: username,
                      label: 'Username',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 14),

                    CustomTextField(
                      controller: fullName,
                      label: 'Full name',
                      prefixIcon: const Icon(Icons.badge),
                    ),
                    const SizedBox(height: 14),

                    CustomTextField(
                      controller: email,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 14),

                    CustomTextField(
                      controller: password,
                      label: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                    ),

                    const SizedBox(height: 24),

                    // REGISTER BUTTON
                    Obx(() {
                      return CustomButton(
                        isLoading: authC.isLoading.value,
                        text: 'Register',
                        onPressed: () {
                          authC.register(
                            username.text.trim(),
                            fullName.text.trim(),
                            email.text.trim(),
                            password.text.trim(),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  "Sudah punya akun? Login",
                  style: TextStyle(
                    color: Color(0xff6F69AC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
