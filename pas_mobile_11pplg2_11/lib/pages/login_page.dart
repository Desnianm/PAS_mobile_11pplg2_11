import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../routes/routes.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();

    final userCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffF5F2FA), 
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Icon(
                Icons.live_tv,
                size: 75,
                color: Color(0xff6F69AC),
              ),

              const SizedBox(height: 12),

             
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3D3A50),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Silahkan Login Untuk Melihat Film ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              
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
                      controller: userCtrl,
                      label: 'Username',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passCtrl,
                      label: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),

                    
                    Obx(() {
                      return CustomButton(
                        isLoading: authC.isLoading.value,
                        text: 'Login',
                        onPressed: () async {
                          await authC.login(
                            userCtrl.text.trim(),
                            passCtrl.text.trim(),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: const Text(
                  'Belum punya akun? Register',
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
