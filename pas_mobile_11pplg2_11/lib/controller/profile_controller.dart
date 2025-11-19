import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_controller.dart';

class ProfileController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var photoUrl = ''.obs; 

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? 'user';
    email.value = prefs.getString('email') ?? 'email@example.com';
    photoUrl.value = prefs.getString('photo') ?? ''; 
  }

  Future<void> logout() async {
    final auth = Get.find<AuthController>();
    await auth.logout();
  }
}
