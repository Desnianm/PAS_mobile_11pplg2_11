import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../widget/custom_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final profileC = Get.find<ProfileController>();

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: profileC.photoUrl.value.isNotEmpty
                    ? NetworkImage(profileC.photoUrl.value)
                    : const NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
              ),

              const SizedBox(height: 20),
              Text(
                profileC.username.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),
              Text(
                profileC.email.value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),
              CustomButton(
                text: "Logout",
                width: double.infinity,
                onPressed: () {
                  profileC.logout();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
